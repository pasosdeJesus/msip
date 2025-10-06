#!/usr/bin/env node
import { Command } from 'commander';
import { loadEnv } from './util/env.js';
import { runDbCreate, runDbDrop, runDbStructureDump, runDbStructureLoad, runDbMigrate, runDbRollback, runDbSeed, runDbSuperCreateUser, runDbConsole } from './tasks/db.js';
import { getCliT } from './i18n.js';

async function main() {
  const t = await getCliT();
  const program = new Command();
  program
    .name('msipn')
    .description(t('cmd.program_description'))
    .version('0.0.1');

  program.command('db:create').description(t('cmd.db.create')).action(async () => { loadEnv(); await runDbCreate(); });
  program.command('db:drop').description(t('cmd.db.drop')).action(async () => { loadEnv(); await runDbDrop(); });
  program.command('db:structure:dump').description(t('cmd.db.structure_dump')).action(async () => { loadEnv(); await runDbStructureDump(); });
  program.command('db:structure:load').description(t('cmd.db.structure_load')).action(async () => { loadEnv(); await runDbStructureLoad(); });
  program.command('db:migrate').description(t('cmd.db.migrate')).action(async () => { loadEnv(); await runDbMigrate(); });
  program.command('db:rollback').description(t('cmd.db.rollback')).action(async () => { loadEnv(); await runDbRollback(); });
  program.command('db:seed').description(t('cmd.db.seed')).action(async () => { loadEnv(); await runDbSeed(); });
  program.command('db:super:createuser').description(t('cmd.db.super_createuser')).action(async () => { loadEnv(); await runDbSuperCreateUser(); });
  program.command('db:console').description(t('cmd.db.console')).action(async () => { loadEnv(); await runDbConsole(); });

  await program.parseAsync(process.argv);
  if (process.exitCode == null) process.exitCode = 0;
}

main().catch(err => {
  console.error(err);
  process.exit(1);
});
