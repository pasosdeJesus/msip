import { execSync } from 'node:child_process';
import { readdirSync, rmSync } from 'node:fs';
import path from 'node:path';
import { describe, it, beforeAll, afterAll, expect } from 'vitest';

// 04: Migraciones core después de preparar rol y base.

const BIN = path.join(process.cwd(), 'bin', 'msipn');

function run(cmd: string) {
  return execSync(cmd, { stdio: 'pipe', env: process.env });
}

function psql(sql: string): string {
  const db = process.env.PGDATABASE || 'msipn_dev';
  const host = process.env.PGHOST || 'localhost';
  const user = process.env.PGUSER;
  if (!user) {
    throw new Error('PGUSER requerido para ejecutar consultas psql en test 04');
  }
  const parts = ['psql', '-h', host, '-U', user, '-t','-A','-F',',','-c', sql, db];
  const cmd = parts.map(p => `'${p.replace(/'/g,"'\\''")}'`).join(' ');
  return execSync(cmd, { stdio: 'pipe', env: process.env, shell: '/bin/sh' }).toString('utf-8').trim();
}

describe('Migraciones núcleo', () => {
  beforeAll(() => {
    const host = process.env.PGHOST || 'localhost';
    const user = process.env.PGUSER || 'msipn';
    const dbname = process.env.PGDATABASE || 'msipn_dev';
    try {
      run(`psql -h '${host}' -U '${user}' '${dbname}' -c 'SELECT 1'`);
    } catch {
      try { run(`${BIN} db:create`); } catch {}
      run(`psql -h '${host}' -U '${user}' '${dbname}' -c 'SELECT 1'`);
    }

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
  });

  it('aplica migraciones núcleo incluyendo tabla example', () => {
    run(`${BIN} db:migrate`);
    const reg = psql("SELECT to_regclass('public.example')");
    expect(reg).toContain('example');
  });

  it('revierte última migración eliminando tabla example', () => {
    run(`${BIN} db:rollback`);
    const reg = psql("SELECT EXISTS (SELECT 1 FROM pg_class WHERE relname='example')::text");
    expect(reg).toContain('f');
  });

  it('vuelve a aplicar migración de example tras re-migrate', () => {
    run(`${BIN} db:migrate`);
    const reg = psql("SELECT to_regclass('public.example')");
    expect(reg).toContain('example');
  });
});
