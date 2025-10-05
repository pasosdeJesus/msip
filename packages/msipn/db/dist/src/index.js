import { Kysely, PostgresDialect } from 'kysely';
import { Pool } from 'pg';
import 'dotenv/config';
let _db = null;
export function getDb() {
    if (_db)
        return _db;
    const pool = new Pool({
        host: process.env.DB_HOST,
        database: process.env.DB_NAME,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        port: process.env.DB_PORT ? parseInt(process.env.DB_PORT, 10) : 5432
    });
    _db = new Kysely({
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
