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
const GITHUB_SPEC = 'github:pasosdeJesus/msip#msipn'
const PEERS = { kysely: '^0.27.3', pg: '^8.11.5' }

// Detect if we should bootstrap: user cwd is a project (package.json present),
// that package.json is NOT this same package, and does not yet depend on ENGINE_PKG.
async function maybeBootstrap() {
  if (process.env.MSIPN_SKIP_BOOTSTRAP === '1') return false
  const cwd = process.cwd()
  const pkgPath = join(cwd, 'package.json')
  if (!existsSync(pkgPath)) {
    return false // nothing to do; just run CLI (likely running inside repo itself)
  }
  let pkg
  try { pkg = JSON.parse(readFileSync(pkgPath, 'utf8')) } catch { return false }
  if (pkg.name === ENGINE_PKG) return false // executing inside repo / package itself
  const hasDep = !!(pkg.dependencies && pkg.dependencies[ENGINE_PKG]) || !!(pkg.devDependencies && pkg.devDependencies[ENGINE_PKG])
  if (hasDep) return false // Already installed; normal CLI flow

  // Bootstrap mode
  console.log('[msipn] Inicializando proyecto (bootstrap)...')
  pkg.dependencies = pkg.dependencies || {}
  pkg.dependencies[ENGINE_PKG] = GITHUB_SPEC
  // Add peers if missing
  for (const [dep, ver] of Object.entries(PEERS)) {
    if (!pkg.dependencies[dep] && !(pkg.devDependencies && pkg.devDependencies[dep])) {
      pkg.dependencies[dep] = ver
      console.log(`[msipn] Añadida dependencia ${dep}@${ver}`)
    }
  }
  writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\n')
  // Create bin wrapper
  const binDir = join(cwd, 'bin')
  mkdirSync(binDir, { recursive: true })
  const binFile = join(binDir, 'msipn')
  if (!existsSync(binFile)) {
    writeFileSync(binFile, "#!/usr/bin/env node\nimport('@pasosdejesus/msipn/bin/msipn.js')\n", { mode: 0o755 })
    console.log('[msipn] Creado bin/msipn')
  } else {
    console.log('[msipn] bin/msipn ya existe (no modificado)')
  }

  // Detect package manager
  const pm = detectPM(cwd)
  console.log(`[msipn] Instalando dependencias con ${pm} ... (puede tardar)`)
  await runInstall(pm)
  console.log('[msipn] Instalación completa. Próximos pasos:')
  console.log('  bin/msipn --help')
  console.log('  bin/msipn db:migrate')
  return true
}

function detectPM(cwd) {
  if (existsSync(join(cwd, 'pnpm-lock.yaml'))) return 'pnpm'
  if (existsSync(join(cwd, 'yarn.lock'))) return 'yarn'
  if (existsSync(join(cwd, 'package-lock.json'))) return 'npm'
  return 'npm'
}

async function runInstall(pm) {
  return new Promise((resolve, reject) => {
    const cmd = pm
    const args = pm === 'yarn' ? [] : ['install']
    const child = spawn(cmd, args, { stdio: 'inherit' })
    child.on('exit', code => {
      if (code === 0) resolve()
      else reject(new Error(`${pm} install exited with code ${code}`))
    })
  })
}

// Main dispatcher
(async () => {
  const bootstrapped = await maybeBootstrap()
  if (bootstrapped) {
    // Done; do not immediately run CLI again (matches README example)
    return
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
