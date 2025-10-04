import { spawnSync } from 'child_process';
import * as path from 'path';
import * as fs from 'fs';

interface PgConfig { database: string; host?: string; port?: string; user?: string; password?: string; }

function pgConfig(): PgConfig {
  return {
    database: process.env.PGDATABASE || 'msipn_dev',
    host: process.env.PGHOST,
    port: process.env.PGPORT,
    user: process.env.PGUSER,
    password: process.env.PGPASSWORD
  };
}

function buildEnvArgs(cfg: PgConfig) {
  const env: Record<string, string> = { ...process.env } as any;
  if (cfg.password) env.PGPASSWORD = cfg.password;
  return env;
}

function psqlArgs(cfg: PgConfig, extra: string[] = []) {
  const args = [] as string[];
  if (cfg.host) args.push('-h', cfg.host);
  if (cfg.port) args.push('-p', cfg.port);
  if (cfg.user) args.push('-U', cfg.user);
  return [...args, ...extra];
}

function run(cmd: string, args: string[], env: any) {
  const res = spawnSync(cmd, args, { stdio: 'inherit', env });
  if (res.status !== 0) {
    throw new Error(`${cmd} fallo con código ${res.status}`);
  }
}

export async function runDbCreate() {
  const cfg = pgConfig();
  const env = buildEnvArgs(cfg);
  run('createdb', [cfg.database], env);
}

export async function runDbDrop() {
  const cfg = pgConfig();
  const env = buildEnvArgs(cfg);
  run('dropdb', ['--if-exists', cfg.database], env);
}

// Esquema → JSON metadata minimal (tablas y columnas) para futura generación
export async function runDbSchemaDump() {
  const cfg = pgConfig();
  const env = buildEnvArgs(cfg);
  const outDir = path.join(process.cwd(), 'db');
  fs.mkdirSync(outDir, { recursive: true });
  const tablesQuery = `SELECT table_name FROM information_schema.tables WHERE table_schema='public' ORDER BY 1`; 
  const tq = spawnSync('psql', [...psqlArgs(cfg), '-t', '-c', tablesQuery, cfg.database], { env, encoding: 'utf-8' });
  if (tq.status !== 0) throw new Error('Fallo listando tablas');
  const tables = tq.stdout.split(/\s+/).map(s=>s.trim()).filter(s=>s.length>0);
  const result: Record<string, any> = {};
  for (const t of tables) {
    const cq = spawnSync('psql', [...psqlArgs(cfg), '-t', '-c', `SELECT column_name, data_type, is_nullable FROM information_schema.columns WHERE table_schema='public' AND table_name='${t}' ORDER BY ordinal_position`, cfg.database], { env, encoding: 'utf-8' });
    if (cq.status !== 0) continue;
    const cols = cq.stdout.split(/\n/).map(l=>l.trim()).filter(l=>l);
    result[t] = cols.map(line => {
      const parts = line.split(/\s+/);
      const [name, dtype, nullable] = parts;
      return { name, type: dtype, nullable: nullable === 'YES' };
    });
  }
  fs.writeFileSync(path.join(outDir, 'schema.metadata.json'), JSON.stringify({ generatedAt: new Date().toISOString(), tables: result }, null, 2));
  console.log('Esquema exportado a db/schema.metadata.json');
}

// Para load: placeholder (en futuro aplicar diff). Ahora sólo informa.
export async function runDbSchemaLoad() {
  const metaFile = path.join(process.cwd(), 'db', 'schema.metadata.json');
  if (!fs.existsSync(metaFile)) {
    console.log('No existe db/schema.metadata.json');
    return;
  }
  console.log('db:schema:load aún no implementa cambios. Archivo leído.');
}

// Migraciones mínimas: archivos numerados en db/migrate/*.sql
function migrationsDir() {
  return path.join(process.cwd(), 'db', 'migrate');
}

function ensureSchemaMigrations(cfg: PgConfig, env: any) {
  const sql = "CREATE TABLE IF NOT EXISTS schema_migrations (version varchar(255) PRIMARY KEY);";
  run('psql', [...psqlArgs(cfg), '-c', sql, cfg.database], env);
}

function appliedMigrations(cfg: PgConfig, env: any): Set<string> {
  const tmp = spawnSync('psql', [...psqlArgs(cfg), '-t', '-c', 'SELECT version FROM schema_migrations', cfg.database], { env, encoding: 'utf-8' });
  if (tmp.status !== 0) return new Set();
  return new Set(tmp.stdout.split(/\s+/).map(s => s.trim()).filter(s => s.length > 0));
}

function recordMigration(cfg: PgConfig, env: any, version: string) {
  run('psql', [...psqlArgs(cfg), '-c', `INSERT INTO schema_migrations(version) VALUES ('${version}') ON CONFLICT DO NOTHING`, cfg.database], env);
}

function deleteMigration(cfg: PgConfig, env: any, version: string) {
  run('psql', [...psqlArgs(cfg), '-c', `DELETE FROM schema_migrations WHERE version='${version}'`, cfg.database], env);
}

export async function runDbMigrate() {
  const cfg = pgConfig();
  const env = buildEnvArgs(cfg);
  ensureSchemaMigrations(cfg, env);
  const dir = migrationsDir();
  if (!fs.existsSync(dir)) return;
  const files = fs.readdirSync(dir).filter(f => /\.sql$/.test(f)).sort();
  const applied = appliedMigrations(cfg, env);
  for (const f of files) {
    const version = f.split('_')[0];
    if (applied.has(version)) continue;
    const full = path.join(dir, f);
    run('psql', [...psqlArgs(cfg), '-f', full, cfg.database], env);
    recordMigration(cfg, env, version);
    console.log(`Migración aplicada ${f}`);
  }
}

export async function runDbRollback() {
  const cfg = pgConfig();
  const env = buildEnvArgs(cfg);
  const dir = migrationsDir();
  if (!fs.existsSync(dir)) return;
  ensureSchemaMigrations(cfg, env);
  const applied = Array.from(appliedMigrations(cfg, env)).sort();
  const last = applied[applied.length - 1];
  if (!last) {
    console.log('No hay migraciones aplicadas');
    return;
  }
  // Buscar archivo con ese prefix y segmento down opcional
  const files = fs.readdirSync(dir).filter(f => f.startsWith(last + '_') && /\.sql$/.test(f));
  if (!files.length) {
    console.log('No se encontró archivo de migración para revertir');
    return;
  }
  const full = path.join(dir, files[0]);
  // Convención simple: separar por '-- DOWN' en el archivo SQL
  const content = fs.readFileSync(full, 'utf-8');
  const parts = content.split(/--\s*DOWN/i);
  if (parts.length < 2) {
    console.log('Migración no tiene sección DOWN, no se revierte.');
    return;
  }
  const downSql = parts[1];
  const tmpFile = path.join(dir, `.rollback_${last}.sql`);
  fs.writeFileSync(tmpFile, downSql);
  try {
    run('psql', [...psqlArgs(cfg), '-f', tmpFile, cfg.database], env);
    deleteMigration(cfg, env, last);
    console.log(`Migración revertida ${files[0]}`);
  } finally {
    fs.unlinkSync(tmpFile);
  }
}

export async function runDbSeed() {
  const cfg = pgConfig();
  const env = buildEnvArgs(cfg);
  const seedSql = path.join(process.cwd(), 'db', 'seeds.sql');
  if (fs.existsSync(seedSql)) {
    run('psql', [...psqlArgs(cfg), '-f', seedSql, cfg.database], env);
    console.log('Seeds SQL aplicados');
  } else {
    console.log('No hay seeds.sql (puede implementarse seeds.ts en el futuro)');
  }
}
