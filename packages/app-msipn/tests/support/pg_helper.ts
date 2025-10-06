// Helper unificado para detección de conectividad PostgreSQL en tests.
// Movido a tests/support/pg_helper.ts

import { spawnSync } from 'node:child_process';
import { readFileSync, existsSync } from 'node:fs';
import path from 'node:path';

export interface PgCheckOptions {
  retries?: number; // intentos adicionales tras el primero
  delayMs?: number; // espera entre reintentos
}

export function checkPgReachable(opts: PgCheckOptions = {}): { ok: boolean; reason?: string } {
  const { retries = 1, delayMs = 150 } = opts;

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
      const host = process.env.PGHOST || 'localhost';
      const user = process.env.PGUSER;
      if (!user) {
        throw new Error('Variable de entorno PGUSER requerida para pruebas');
      }
      args.push('-h', host);
      args.push('-U', user);
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

export function requireOrSkipPg(_testLabel: string): boolean {
  const res = checkPgReachable({ retries: 2, delayMs: 200 });
  if (!res.ok) {
    throw new Error(`PostgreSQL requerido para pruebas no accesible: ${res.reason}`);
  }
  return true;
}
