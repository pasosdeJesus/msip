import { execSync } from 'node:child_process';
import { existsSync, readdirSync, rmSync } from 'node:fs';
import path from 'node:path';
import { describe, it, beforeAll, afterAll, expect } from 'vitest';

const BIN = path.join(process.cwd(), 'bin', 'msipn');

function run(cmd: string) {
  return execSync(cmd, { stdio: 'pipe', env: process.env });
}

// Utilidad para ejecutar SQL y retornar filas usando psql -t -A -F ','
function psql(sql: string): string {
  const db = process.env.PGDATABASE || 'msipn_dev';
  const host = process.env.PGHOST;
  const user = process.env.PGUSER;
  const parts = ['psql'];
  if (host) parts.push('-h', host);
  if (user) parts.push('-U', user);
  parts.push('-t','-A','-F',',','-c', sql, db);
  // Escapar cada parte para shell seguro
  const cmd = parts.map(p => `'${p.replace(/'/g,"'\\''")}'`).join(' ');
  return execSync(cmd, { stdio: 'pipe', env: process.env, shell: '/bin/sh' }).toString('utf-8').trim();
}

describe('core migrations', () => {
  beforeAll(() => {
    // asegurar db fresca
    try { run(`${BIN} db:drop`); } catch {}
    run(`${BIN} db:create`);
    // Eliminar migraciones dinámicas de la app que puedan alterar orden y última migración
    const appMigDir = path.join(process.cwd(), 'db', 'migrations');
    try {
      for (const f of readdirSync(appMigDir)) {
        if (/__create_example_inapp\.(t|j)s$/.test(f)) {
          rmSync(path.join(appMigDir, f));
        }
      }
    } catch {}
  });

  afterAll(() => {
    try { run(`${BIN} db:drop`); } catch {}
  });

  it('applies core migrations including example table', () => {
    run(`${BIN} db:migrate`);
    const reg = psql("SELECT to_regclass('public.example')");
    expect(reg).toContain('example');
  });

  it('rolls back last migration removing example table', () => {
    run(`${BIN} db:rollback`);
    // Usamos EXISTS para evitar espacios o salidas inesperadas de to_regclass
    const reg = psql("SELECT EXISTS (SELECT 1 FROM pg_class WHERE relname='example')::text");
    expect(reg).toContain('f'); // debe ser falsa la existencia tras rollback
  });

  it('re-applies example after re-migrate', () => {
    run(`${BIN} db:migrate`);
    const reg = psql("SELECT to_regclass('public.example')");
    expect(reg).toContain('example');
  });
});
