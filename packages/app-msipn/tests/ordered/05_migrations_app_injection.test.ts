import { execSync } from 'node:child_process';
import { writeFileSync, mkdirSync, readdirSync, rmSync } from 'node:fs';
import path from 'node:path';
import { describe, it, beforeAll, afterAll, expect } from 'vitest';
import { requireOrSkipPg } from '../support/pg_helper';

// 05: Prueba inyección migraciones app.

const BIN = path.join(process.cwd(), 'bin', 'msipn');

function run(cmd: string) {
  return execSync(cmd, { stdio: 'pipe', env: process.env });
}

function psql(sql: string): string {
  const db = process.env.PGDATABASE || 'msipn_dev';
  const host = process.env.PGHOST || 'localhost';
  const user = process.env.PGUSER;
  if (!user) throw new Error('PGUSER requerido para test 05');
  const parts = ['psql', '-h', host, '-U', user, '-t','-A','-F',',','-c', sql, db];
  const cmd = parts.map(p => `'${p.replace(/'/g,"'\\''")}'`).join(' ');
  return execSync(cmd, { stdio: 'pipe', env: process.env, shell: '/bin/sh' }).toString('utf-8').trim();
}

// Verifica conexión obligatoria (lanza si no hay PostgreSQL)
requireOrSkipPg('app-level migrations');

describe('Migraciones dinámicas de la aplicación', () => {
  const migDir = path.join(process.cwd(), 'db', 'migrations');
  const migName = `${new Date().toISOString().replace(/[-:TZ.]/g,'').slice(0,12)}__create_example_inapp`;
  const migFile = path.join(migDir, `${migName}.js`);

  beforeAll(() => {
    // Asegura base limpia sin fallar si no existe
    try { run(`${BIN} db:drop`); } catch {}
    try { run(`${BIN} db:create`); } catch {}
    mkdirSync(migDir, { recursive: true });
    for (const f of readdirSync(migDir)) {
      if (/__create_example_inapp\.(t|j)s$/.test(f)) { rmSync(path.join(migDir, f)); }
    }
    const content = `export async function up(db){ await db.schema\n      .createTable('example_inapp')\n      .addColumn('id','serial',(c)=>c.primaryKey())\n      .addColumn('nombre','varchar',(c)=>c.notNull())\n      .execute(); }\nexport async function down(db){ await db.schema.dropTable('example_inapp').execute(); }`;
    writeFileSync(migFile, content, 'utf-8');
  });

  afterAll(() => {
    try { run(`${BIN} db:rollback`); } catch {}
    try {
      for (const f of readdirSync(migDir)) {
        if (/__create_example_inapp\.(t|j)s$/.test(f)) {
          rmSync(path.join(migDir, f));
        }
      }
    } catch {}
  });

  it('aplica migración dinámica de la aplicación', () => {
    const out = run(`${BIN} db:migrate`);
    expect(out.toString()).toContain(migName);
    const reg = psql("SELECT EXISTS (SELECT 1 FROM pg_class WHERE relname='example_inapp')::text");
    expect(reg).toContain('t');
  });

  it('rollback elimina tabla example_inapp', () => {
    run(`${BIN} db:rollback`);
    const reg = psql("SELECT to_regclass('public.example_inapp')");
    expect(reg.trim() === '' || reg.includes('[NULL]')).toBeTruthy();
  });
});
