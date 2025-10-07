#!/usr/bin/env node
// msipn-init: Bootstraps an external project to use msipn from GitHub branch.
// Usage: npx github:pasosdeJesus/msip#msipn msipn-init [--pm npm|pnpm|yarn] [--force] [--yes]
// Adds dependency on @pasosdejesus/msipn (Git URL) plus peer deps (kysely, pg) if missing.

import fs from 'node:fs'
import path from 'node:path'
import { spawn } from 'node:child_process'

const GIT_SPEC = 'github:pasosdeJesus/msip#msipn'
const ENGINE_PKG = '@pasosdejesus/msipn'
const PEERS = { kysely: '^0.27.3', pg: '^8.11.5' }

function parseArgs(argv) {
  const args = { pm: 'auto', force: false, yes: false }
  for (let i = 2; i < argv.length; i++) {
    const a = argv[i]
    if (a === '--force') args.force = true
    else if (a === '--yes' || a === '-y') args.yes = true
    else if (a.startsWith('--pm=')) args.pm = a.split('=')[1]
    else if (a === '--pm') { args.pm = argv[++i] }
    else if (a === '--help' || a === '-h') { args.help = true }
    else args._ = (args._ || []).concat(a)
  }
  return args
}

function detectPackageManager(cwd, override) {
  if (override && override !== 'auto') return override
  if (fs.existsSync(path.join(cwd, 'pnpm-lock.yaml'))) return 'pnpm'
  if (fs.existsSync(path.join(cwd, 'yarn.lock'))) return 'yarn'
  if (fs.existsSync(path.join(cwd, 'package-lock.json'))) return 'npm'
  return 'npm'
}

function readJSON(p) {
  return JSON.parse(fs.readFileSync(p, 'utf8'))
}

function writeJSON(p, obj) {
  fs.writeFileSync(p, JSON.stringify(obj, null, 2) + '\n')
}

function confirm(question) {
  return new Promise(resolve => {
    process.stdout.write(question + ' ')
    process.stdin.resume()
    process.stdin.setEncoding('utf8')
    process.stdin.once('data', d => {
      const ans = d.trim().toLowerCase()
      resolve(ans === 'y' || ans === 'yes')
    })
  })
}

async function main() {
  const args = parseArgs(process.argv)
  if (args.help) {
    console.log(`msipn-init\n\nOptions:\n  --pm <npm|pnpm|yarn>  Choose package manager (auto-detect default)\n  --force               Overwrite existing dependency versions\n  -y, --yes             Skip interactive confirmations\n  -h, --help            Show help`)    
    return
  }
  const cwd = process.cwd()
  const pkgPath = path.join(cwd, 'package.json')
  if (!fs.existsSync(pkgPath)) {
    console.error('No package.json found in current directory. Run inside a Node project.')
    process.exit(1)
  }
  const pkg = readJSON(pkgPath)

  pkg.dependencies = pkg.dependencies || {}

  const existing = pkg.dependencies[ENGINE_PKG] || pkg.devDependencies?.[ENGINE_PKG]
  if (existing && existing !== GIT_SPEC && !args.force) {
    console.error(`Dependency ${ENGINE_PKG} already present with version ${existing}. Use --force to overwrite.`)
    process.exit(1)
  }

  if (!existing || args.force) {
    pkg.dependencies[ENGINE_PKG] = GIT_SPEC
    console.log(`Added ${ENGINE_PKG} -> ${GIT_SPEC}`)
  }

  for (const [dep, ver] of Object.entries(PEERS)) {
    if (!pkg.dependencies[dep] && !pkg.devDependencies?.[dep]) {
      pkg.dependencies[dep] = ver
      console.log(`Added peer dependency ${dep}@${ver}`)
    }
  }

  pkg.scripts = pkg.scripts || {}
  if (!pkg.scripts['db:migrate']) pkg.scripts['db:migrate'] = 'msipn db:migrate'
  if (!pkg.scripts['db:rollback']) pkg.scripts['db:rollback'] = 'msipn db:rollback'
  if (!pkg.scripts['db:console']) pkg.scripts['db:console'] = 'msipn db:console'

  writeJSON(pkgPath, pkg)
  console.log('Updated package.json')

  const pm = detectPackageManager(cwd, args.pm)
  let proceed = args.yes
  if (!proceed) {
    proceed = await confirm(`Run dependency installation with ${pm}? (y/N)`) 
  }
  if (!proceed) {
    console.log('Aborted before install. Run your package manager manually to install dependencies.')
    return
  }
  const installCmd = pm === 'pnpm' ? 'pnpm' : pm === 'yarn' ? 'yarn' : 'npm'
  const installArgs = pm === 'yarn' ? [] : ['install']
  console.log(`Running ${installCmd} ${installArgs.join(' ')}`)
  const child = spawn(installCmd, installArgs, { stdio: 'inherit' })
  child.on('exit', code => {
    if (code !== 0) {
      console.error(`Install failed with code ${code}`)
      process.exit(code ?? 1)
    } else {
      console.log('Install completed. You can now run:')
      console.log('  npm run db:migrate  (or pnpm/yarn)')
      console.log('  npx msipn --help')
    }
  })
}

main().catch(err => { console.error(err); process.exit(1) })
