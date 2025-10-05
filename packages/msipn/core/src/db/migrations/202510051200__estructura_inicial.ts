// Migración inicial (core) derivada de test/dummy/db/structure.sql (fragmento inicial)
// Para ampliar gradualmente agregue nuevas migraciones con secciones adicionales.
import { Kysely, sql } from 'kysely';

export async function up(db: Kysely<any>): Promise<void> {
  const rawInit = `SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
-- Omitimos cambio de search_path para no interferir con tablas de tracking de migraciones
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE COLLATION IF NOT EXISTS public.es_co_utf_8 (provider = libc, locale = 'es_CO.UTF-8');
CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;
COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';`;
  for (const stmt of rawInit.split(/;\n/)) {
    const s = stmt.trim();
    if (s.length > 0) {
      await sql.raw(s + ';').execute(db);
    }
  }
}

export async function down(db: Kysely<any>): Promise<void> {
  await sql`DROP SCHEMA IF EXISTS public CASCADE;`.execute(db);
  await sql`CREATE SCHEMA public;`.execute(db);
  await sql`GRANT ALL ON SCHEMA public TO public;`.execute(db);
}
