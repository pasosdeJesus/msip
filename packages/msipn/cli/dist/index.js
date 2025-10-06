#!/usr/bin/env node
import { Command } from 'commander';
import pc from 'picocolors';
import { loadEnv } from './util/env.js';
import { runDbCreate, runDbDrop, runDbStructureDump, runDbStructureLoad, runDbMigrate, runDbRollback, runDbSeed, runDbSuperCreateUser, runDbConsole } from './tasks/db.js';
import { getCliT } from './i18n.js';
import { detectLocale } from './util/locale.js';
async function main() {
    const locale = detectLocale();
    const t = await getCliT(locale);
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
    // Override help to color command names blue
    const origHelp = program.helpInformation;
    const usageLabel = t('cmd.help.usage');
    const optionsLabel = t('cmd.help.options');
    const commandsLabel = t('cmd.help.commands');
    const displayHelp = t('cmd.help.display_help');
    const versionDesc = t('cmd.help.version_desc');
    const helpDesc = t('cmd.help.help_desc');
    const phOptions = t('cmd.help.placeholder_options');
    const phCommand = t('cmd.help.placeholder_command');
    // Patch built-in help command description (commander registers it automatically)
    const helpCmd = program.commands.find(c => c.name() === 'help');
    if (helpCmd)
        helpCmd.description(displayHelp);
    program.helpInformation = function () {
        let raw = origHelp.call(this);
        // Replace headings (start of line)
        raw = raw.replace(/^Usage:/m, usageLabel + ':');
        raw = raw.replace(/^Options:/m, optionsLabel + ':');
        raw = raw.replace(/^Commands:/m, commandsLabel + ':');
        // Normalize placeholders in usage line
        raw = raw.replace(/\[options\]/, phOptions).replace(/\[command\]/, phCommand);
        // Replace default commander option help lines
        // version flag line
        raw = raw.replace(/-V, --version\s+.*\n/, (m) => m.replace(/-V, --version\s+.*/, `-V, --version        ${versionDesc}\n`));
        // help flag line
        raw = raw.replace(/-h, --help\s+.*\n/, (m) => m.replace(/-h, --help\s+.*/, `-h, --help           ${helpDesc}\n`));
        // help command listing line
        const helpCmdRegex = new RegExp(`(^\s{2}help )\[command\](\s+).*$`, 'm');
        raw = raw.replace(helpCmdRegex, (_, p1, spaces) => `${p1}${phCommand}${spaces}${helpDesc}`);
        // Final pass: if Spanish force replace any residual help line tokens
        if (locale === 'es') {
            // Replace help command listing regardless of current placeholder
            raw = raw.replace(/(^\s{2}help) \[(?:command|orden)\](\s+)display help for command/m, `$1 ${phCommand}$2${helpDesc}`);
            raw = raw.replace(/(^\s{2}help) \[(?:command|orden)\](\s+)presenta ayuda para una orden/m, `$1 ${phCommand}$2${helpDesc}`);
        }
        const lines = raw.split('\n');
        let inCommands = false;
        const out = lines.map(line => {
            if (new RegExp('^' + commandsLabel + ':').test(line)) {
                inCommands = true;
                return line;
            }
            if (inCommands) {
                if (/^\s*$/.test(line)) {
                    inCommands = false;
                    return line;
                }
                const m = line.match(/^(\s{2})([a-zA-Z0-9:_-]+)(\s{2,}.*)$/);
                if (m) {
                    const [, ws, cmd, rest] = m;
                    return ws + pc.blue(cmd) + rest;
                }
            }
            return line;
        });
        return out.join('\n');
    };
    await program.parseAsync(process.argv);
    if (process.exitCode == null)
        process.exitCode = 0;
}
main().catch(err => {
    console.error(err);
    process.exit(1);
});
