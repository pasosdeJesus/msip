import { execSync } from 'node:child_process';
import { writeFileSync, mkdirSync, readdirSync, rmSync } from 'node:fs';
import path from 'node:path';
import { describe, it, beforeAll, afterAll, expect } from 'vitest';

const BIN = path.join(process.cwd(), 'bin', 'msipn');

function run(cmd: string) {
  return execSync(cmd, { stdio: 'pipe', env: process.env });
}

function psql(sql: string): string {
  const db = process.env.PGDATABASE || 'msipn_dev';
  const host = process.env.PGHOST;
  const user = process.env.PGUSER;
  const parts = ['psql'];
  if (host) parts.push('-h', host);
  if (user) parts.push('-U', user);
  parts.push('-t','-A','-F',',','-c', sql, db);
  const cmd = parts.map(p => `'${p.replace(/'/g,"'\\''")}'`).join(' ');
  return execSync(cmd, { stdio: 'pipe', env: process.env, shell: '/bin/bash' }).toString('utf-8').trim();
}

describe('app-level migration dynamic creation', () => {
  const migDir = path.join(process.cwd(), 'db', 'migrations');
  // Usamos precisión a minutos para nombre estable durante la ejecución del test
  const migName = `${new Date().toISOString().replace(/[-:TZ.]/g,'').slice(0,12)}__create_example_inapp`;
  const migFile = path.join(migDir, `${migName}.js`);

  beforeAll(() => {
    try { run(`${BIN} db:drop`); } catch {}
    run(`${BIN} db:create`);
    mkdirSync(migDir, { recursive: true });
    // Limpiar migraciones previas example_inapp para asegurar que sólo exista una
    for (const f of readdirSync(migDir)) {
      if (/__create_example_inapp\.(t|j)s$/.test(f)) {
        rmSync(path.join(migDir, f));
      }
    }
    const content = `export async function up(db){ await db.schema\n      .createTable('example_inapp')\n      .addColumn('id','serial',(c)=>c.primaryKey())\n      .addColumn('nombre','varchar',(c)=>c.notNull())\n      .execute(); }\nexport async function down(db){ await db.schema.dropTable('example_inapp').execute(); }`;
    writeFileSync(migFile, content, 'utf-8');
  });

  afterAll(() => {
    // cleanup: rollback if applied, drop db, remove file (left for dev inspection maybe)
    try { run(`${BIN} db:rollback`); } catch {}
    try { run(`${BIN} db:drop`); } catch {}
  });

  it('applies dynamic app migration', () => {
    const out = run(`${BIN} db:migrate`);
    // Debe listar la migración creada en mapa combinado
    expect(out.toString()).toContain(migName);
    const reg = psql("SELECT EXISTS (SELECT 1 FROM pg_class WHERE relname='example_inapp')::text");
    expect(reg).toContain('t');
  });

  it('rollback removes example_inapp', () => {
    run(`${BIN} db:rollback`);
    const reg = psql("SELECT to_regclass('public.example_inapp')");
    expect(reg === '' || reg === ' ').toBeTruthy();
  });
});
