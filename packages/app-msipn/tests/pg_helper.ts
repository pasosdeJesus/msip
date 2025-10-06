// Helper unificado para detección de conectividad PostgreSQL en tests.
// Proporciona retry ligero y variable TEST_FORCE_DB para convertir skip en fallo.

import { spawnSync } from 'node:child_process';
import { readFileSync, existsSync } from 'node:fs';
import path from 'node:path';

export interface PgCheckOptions {
  retries?: number; // intentos adicionales tras el primero
  delayMs?: number; // espera entre reintentos
}

export function checkPgReachable(opts: PgCheckOptions = {}): { ok: boolean; reason?: string } {
  const { retries = 1, delayMs = 150 } = opts;

  // Cargar .env si faltan credenciales básicas y no se ha cargado antes
  const needEnv = !process.env.PGUSER || !process.env.PGDATABASE;
  if (needEnv) {
    try {
      const envPath = path.join(process.cwd(), '.env');
      if (existsSync(envPath)) {
        const raw = readFileSync(envPath, 'utf-8');
        raw.split(/\r?\n/).forEach(line => {
          const m = line.match(/^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)\s*$/);
          if (!m) return;
          let [, key, val] = m;
          if (val.startsWith('"') && val.endsWith('"')) { val = val.slice(1, -1); }
          else if (val.startsWith("'") && val.endsWith("'")) { val = val.slice(1, -1); }
          if (!(key in process.env)) {
            process.env[key] = val;
          }
        });
      }
    } catch { /* silencioso */ }
  }

  const attempt = (): boolean => {
    try {
      const args: string[] = [];
      if (process.env.PGHOST) {
        args.push('-h', process.env.PGHOST);
      }
      if (process.env.PGUSER) {
        args.push('-U', process.env.PGUSER);
      }
      if (process.env.PGDATABASE) {
        args.push('-d', process.env.PGDATABASE);
      }
      args.push('-c', 'SELECT 1');
      const r = spawnSync('psql', args, { env: process.env });
      return r.status === 0;
    } catch { return false; }
  };
  if (attempt()) return { ok: true };
  for (let i = 0; i < retries; i++) {
    Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, delayMs);
    if (attempt()) return { ok: true };
  }
  return { ok: false, reason: 'psql no responde SELECT 1 con variables actuales (.env intentado)' };
}

export function requireOrSkipPg(testLabel: string): boolean {
  const force = process.env.TEST_FORCE_DB === '1';
  const res = checkPgReachable({ retries: 2, delayMs: 200 });
  if (!res.ok) {
    const msg = `[skip] ${testLabel}: PostgreSQL no accesible (${res.reason}).`;
    if (force) {
      // eslint-disable-next-line no-console
      console.error(msg + ' (TEST_FORCE_DB=1 => fallo)');
      throw new Error(msg);
    }
    // eslint-disable-next-line no-console
    console.warn(msg);
    return false;
  }
  return true;
}
