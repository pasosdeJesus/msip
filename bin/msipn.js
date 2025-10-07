#!/usr/bin/env node
// Root wrapper that delegates to the actual CLI package inside the monorepo.
// It ensures the workspace build has occurred (prepare script handles build).

import { createRequire } from 'module'
import { fileURLToPath } from 'url'
import { dirname, resolve } from 'path'
import { existsSync } from 'fs'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

// Path to the CLI package relative to repo root
const cliRoot = resolve(__dirname, '../packages/msipn/cli')
const distEntry = resolve(cliRoot, 'dist/index.js')
const srcFallback = resolve(cliRoot, 'src/index.ts')

if (!existsSync(distEntry)) {
  // Attempt dynamic build? Avoid extra deps; rely on prepare. Just warn.
  console.warn('[msipn] Warning: dist build not found, attempting to use source (may require ts-node preinstalled).')
  if (!existsSync(srcFallback)) {
    console.error('[msipn] Fatal: Neither dist nor source entry located. Aborting.')
    process.exit(1)
  }
  // Try ts-node/tsx if available in PATH
  const req = createRequire(import.meta.url)
  let runner = null
  try {
    runner = req.resolve('tsx')
  } catch (_) {
    console.error('[msipn] tsx not found; please build the CLI (pnpm run build).')
    process.exit(1)
  }
  // Re-exec via tsx
  const { spawn } = await import('node:child_process')
  const cp = spawn(process.execPath, [runner, srcFallback, ...process.argv.slice(2)], { stdio: 'inherit' })
  cp.on('exit', (code) => process.exit(code ?? 1))
} else {
  // Importing the compiled CLI triggers its top-level main() execution.
  await import(distEntry)
}
