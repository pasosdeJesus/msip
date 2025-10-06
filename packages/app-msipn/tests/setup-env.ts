// Test environment bootstrap: load variables from .env manually before any tests run.
// This file is automatically loaded by Vitest (configured via pattern) if present.

import { readFileSync, existsSync } from 'node:fs';
import path from 'node:path';

(function loadEnv() {
  const envPath = path.join(process.cwd(), '.env');
  if (!existsSync(envPath)) {
    // eslint-disable-next-line no-console
    console.warn('[test-setup] .env file not found, skipping load');
    return;
  }
  try {
    const raw = readFileSync(envPath, 'utf-8');
    raw.split(/\r?\n/).forEach(line => {
      const m = line.match(/^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)\s*$/);
      if (!m) return;
      let [, key, val] = m;
      if (val.startsWith('"') && val.endsWith('"')) {
        val = val.slice(1, -1);
      } else if (val.startsWith("'") && val.endsWith("'")) {
        val = val.slice(1, -1);
      }
      if (!(key in process.env)) {
        process.env[key] = val;
      }
    });
    // eslint-disable-next-line no-console
    console.log('[test-setup] .env parsed manually');
  } catch (e) {
    // eslint-disable-next-line no-console
    console.warn('[test-setup] error parsing .env:', (e as Error).message);
  }
})();
