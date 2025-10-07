#!/usr/bin/env node
// msipn bootstrap + dispatcher
// Escenario buscado en README: "npx github:pasosdeJesus/msip#msipn" debe:
// 1. Agregar dependencia @pasosdejesus/msipn (si falta)
// 2. Agregar peers requeridos (kysely, pg) si faltan
// 3. Crear bin/msipn (wrapper ESM) si no existe
// 4. Instalar dependencias
// 5. Salir mostrando próximos pasos
// Si ya está instalado, actúa como wrapper normal del CLI.

import { fileURLToPath } from 'url'
import { dirname, resolve, join } from 'path'
import { existsSync, readFileSync, writeFileSync, mkdirSync } from 'fs'
import { spawn } from 'node:child_process'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

const ENGINE_PKG = '@pasosdejesus/msipn'
console.error('[msipn] Bin iniciado (diagnóstico temporal).')
const GITHUB_SPEC = 'github:pasosdeJesus/msip#msipn'
const PEERS = { kysely: '^0.27.3', pg: '^8.11.5' }

// Detect if we should bootstrap: user cwd is a project (package.json present),
// that package.json is NOT this same package, and does not yet depend on ENGINE_PKG.
function loadJson(path) { try { return JSON.parse(readFileSync(path, 'utf8')) } catch { return null } }

function resolveTargetCwd() {
  // Prefer explicit override
  if (process.env.MSIPN_TARGET_DIR) return process.env.MSIPN_TARGET_DIR
  // INIT_CWD is set by npm/pnpm for lifecycle scripts; sometimes available under npx
  if (process.env.INIT_CWD) return process.env.INIT_CWD
  // If current package.json is ours, try parent of sandbox pattern: /tmp or npm cache extraction
  const cwd = process.cwd()
  return cwd
}

function isSandbox(pkg) {
  // Heuristic: if the current package name is ENGINE_PKG itself, or private true with version matching, treat as sandbox
  return pkg && pkg.name === ENGINE_PKG
}

async function bootstrapIn(targetDir) {
  const pkgPath = join(targetDir, 'package.json')
  let pkg = loadJson(pkgPath)
  if (!pkg) {
    console.error('[msipn] No se encontró package.json en directorio destino para bootstrap:', targetDir)
    return false
  }
  if (pkg.name === ENGINE_PKG) {
    console.log('[msipn] Directorio destino parece ser el propio paquete; se omite bootstrap')
    return false
  }
  const hasDep = (pkg.dependencies && pkg.dependencies[ENGINE_PKG]) || (pkg.devDependencies && pkg.devDependencies[ENGINE_PKG])
  if (hasDep) return false
  console.log('[msipn] Inicializando proyecto (bootstrap) en', targetDir)
  pkg.dependencies = pkg.dependencies || {}
  pkg.dependencies[ENGINE_PKG] = GITHUB_SPEC
  for (const [dep, ver] of Object.entries(PEERS)) {
    if (!pkg.dependencies[dep] && !(pkg.devDependencies && pkg.devDependencies[dep])) {
      pkg.dependencies[dep] = ver
      console.log(`[msipn] Añadida dependencia ${dep}@${ver}`)
    }
  }
  writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\n')
  const binDir = join(targetDir, 'bin')
  mkdirSync(binDir, { recursive: true })
  const binFile = join(binDir, 'msipn')
  if (!existsSync(binFile)) {
    writeFileSync(binFile, "#!/usr/bin/env node\nimport('@pasosdejesus/msipn/bin/msipn.js')\n", { mode: 0o755 })
    console.log('[msipn] Creado bin/msipn')
  }
  const pm = detectPM(targetDir)
  console.log(`[msipn] Instalando dependencias con ${pm} en ${targetDir}`)
  await runInstall(pm, targetDir)
  console.log('[msipn] Instalación completa. Próximos pasos:')
  console.log('  bin/msipn --help')
  console.log('  bin/msipn db:migrate')
  return true
}

async function maybeBootstrap() {
  if (process.env.MSIPN_SKIP_BOOTSTRAP === '1') return false
  const cwd = process.cwd()
  const pkgPath = join(cwd, 'package.json')
  const pkg = loadJson(pkgPath)
  if (!pkg) return false
  if (!isSandbox(pkg)) {
    // Acting directly in target directory
    return await bootstrapIn(cwd)
  }
  // We are in sandbox; attempt to use INIT_CWD or user provided directory
  const target = resolveTargetCwd()
  if (target && target !== cwd) {
    return await bootstrapIn(target)
  }
  return false
}

function detectPM(cwd) {
  if (existsSync(join(cwd, 'pnpm-lock.yaml'))) return 'pnpm'
  if (existsSync(join(cwd, 'yarn.lock'))) return 'yarn'
  if (existsSync(join(cwd, 'package-lock.json'))) return 'npm'
  return 'npm'
}

async function runInstall(pm, dir) {
  return new Promise((resolve, reject) => {
    const cmd = pm
    const args = pm === 'yarn' ? [] : ['install']
    const child = spawn(cmd, args, { stdio: 'inherit', cwd: dir })
    child.on('exit', code => {
      if (code === 0) resolve()
      else reject(new Error(`${pm} install exited with code ${code}`))
    })
  })
}

// Main dispatcher
(async () => {
  // Check if user explicitly wants the "add" command
  const hasAddCommand = process.argv.includes('add')
  
  if (hasAddCommand) {
    // For explicit "add" command, run the CLI normally (it will handle the add command)
    // Skip automatic bootstrap
  } else {
    // For other cases, try automatic bootstrap
    const bootstrapped = await maybeBootstrap()
    if (bootstrapped) {
      // Done; do not immediately run CLI again (matches README example)
      return
    }
  }

  // Normal CLI execution (inside package or already installed project)
  const cliRoot = resolve(__dirname, '../packages/msipn/cli')
  const distEntry = resolve(cliRoot, 'dist/index.js')
  const srcFallback = resolve(cliRoot, 'src/index.ts')

  if (!existsSync(distEntry)) {
    console.warn('[msipn] Warning: dist build not found, attempting to use source (requiere tsx)')
    if (!existsSync(srcFallback)) {
      console.error('[msipn] Fatal: No se encontró dist ni src/index.ts')
      process.exit(1)
    }
    let runner
    try {
      runner = (await import('tsx')).default // attempt to load tsx
    } catch {
      console.error('[msipn] tsx no disponible; ejecute build primero')
      process.exit(1)
    }
    // Fallback: dynamic import of source via tsx/register (simplified)
    await import(srcFallback)
  } else {
    await import(distEntry)
  }
})().catch(e => { console.error('[msipn] Error:', e); process.exit(1) })
