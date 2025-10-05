import { Kysely, sql } from 'kysely';

// Second migration: create a simple example table to validate multi-source migrate & rollback
export async function up(db: Kysely<any>): Promise<void> {
  await db.schema.createTable('example')
    .addColumn('id', 'serial', col => col.primaryKey())
    .addColumn('name', 'varchar(100)', col => col.notNull())
    .addColumn('created_at', 'timestamptz', col => col.defaultTo(sql`now()`))
    .execute();
  await sql`INSERT INTO example (name) VALUES ('seed one'), ('seed two')`.execute(db);
}

export async function down(db: Kysely<any>): Promise<void> {
  await db.schema.dropTable('example').ifExists().execute();
}
