#!/usr/bin/env node
import { Command } from 'commander';
import { loadEnv } from './util/env.js';
import { runDbCreate, runDbDrop, runDbStructureDump, runDbStructureLoad, runDbMigrate, runDbRollback, runDbSeed, runDbSuperCreateUser, runDbConsole } from './tasks/db.js';
const program = new Command();
program
    .name('msipn')
    .description('CLI msipn (inspirado en bin/rails)')
    .version('0.0.1');
program.command('db:create').description('Crea la base de datos').action(async () => { loadEnv(); await runDbCreate(); });
program.command('db:drop').description('Elimina la base de datos').action(async () => { loadEnv(); await runDbDrop(); });
program.command('db:structure:dump').description('Vuelca estructura de la BD actual a db/structure.sql (pg_dump)').action(async () => { loadEnv(); await runDbStructureDump(); });
program.command('db:structure:load').description('Crea (si falta) y aplica estructura desde db/structure.sql (psql)').action(async () => { loadEnv(); await runDbStructureLoad(); });
program.command('db:migrate').description('Corre migraciones pendientes').action(async () => { loadEnv(); await runDbMigrate(); });
program.command('db:rollback').description('Revierte última migración').action(async () => { loadEnv(); await runDbRollback(); });
program.command('db:seed').description('Carga datos semilla').action(async () => { loadEnv(); await runDbSeed(); });
program.command('db:super:createuser').description('Crea (si no existe) un rol superusuario PGUSER con PGPASSWORD').action(async () => { loadEnv(); await runDbSuperCreateUser(); });
program.command('db:console').description('Abre una consola psql con variables del .env actual').action(async () => { loadEnv(); await runDbConsole(); });
program.parseAsync(process.argv)
    .then(() => {
    // Éxito explícito: no cambiar exit code si ya hay uno distinto de 0
    if (process.exitCode == null) {
        process.exitCode = 0;
    }
})
    .catch(err => {
    console.error(err);
    process.exit(1);
});
