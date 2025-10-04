#!/usr/bin/env node
import { Command } from 'commander';
import { loadEnv } from './util/env.js';
import { runDbCreate, runDbDrop, runDbSchemaDump, runDbSchemaLoad, runDbMigrate, runDbRollback, runDbSeed } from './tasks/db.js';

const program = new Command();
program
  .name('msipn')
  .description('CLI msipn (inspirado en bin/rails)')
  .version('0.0.1');

program.command('db:create').description('Crea la base de datos').action(async () => { loadEnv(); await runDbCreate(); });
program.command('db:drop').description('Elimina la base de datos').action(async () => { loadEnv(); await runDbDrop(); });
program.command('db:schema:dump').description('Genera metadata de esquema (kysely + msipn)').action(async () => { loadEnv(); await runDbSchemaDump(); });
program.command('db:schema:load').description('Crea/modifica esquema según metadata').action(async () => { loadEnv(); await runDbSchemaLoad(); });
program.command('db:migrate').description('Corre migraciones pendientes').action(async () => { loadEnv(); await runDbMigrate(); });
program.command('db:rollback').description('Revierte última migración').action(async () => { loadEnv(); await runDbRollback(); });
program.command('db:seed').description('Carga datos semilla').action(async () => { loadEnv(); await runDbSeed(); });

program.parseAsync(process.argv);
