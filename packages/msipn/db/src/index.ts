import { Kysely, PostgresDialect } from 'kysely';
import { Pool } from 'pg';
import 'dotenv/config';
// Si existe codegen se importará DB de db.d.ts; de lo contrario usar any.
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export type DB = any; // Reemplazar tras ejecutar codegen

let _db: Kysely<DB> | null = null;

export function getDb(): Kysely<DB> {
  if (_db) return _db;
  const pool = new Pool({
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : 5432
  });
  _db = new Kysely<DB>({
    dialect: new PostgresDialect({ pool })
  });
  return _db;
}

export async function closeDb() {
  if (_db) {
    await _db.destroy();
    _db = null;
  }
}