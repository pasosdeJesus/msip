/// <reference types="node" />
import { spawnSync } from 'child_process';
import * as fs from 'fs';
import * as os from 'os';
import * as path from 'path';
import { success, problem, info, warn } from '../util/colors.js';
function pgConfig() {
    return {
        database: process.env.PGDATABASE || 'msipn_dev',
        host: process.env.PGHOST,
        port: process.env.PGPORT,
        user: process.env.PGUSER,
        password: process.env.PGPASSWORD
    };
}
function buildEnvArgs(cfg) {
    const env = { ...process.env };
    if (cfg.password)
        env.PGPASSWORD = cfg.password;
    return env;
}
function psqlArgs(cfg, extra = []) {
    const args = [];
    if (cfg.host)
        args.push('-h', cfg.host);
    if (cfg.port)
        args.push('-p', cfg.port);
    if (cfg.user)
        args.push('-U', cfg.user);
    return [...args, ...extra];
}
function run(cmd, args, env) {
    const res = spawnSync(cmd, args, { stdio: 'inherit', env });
    if (res.status !== 0) {
        throw new Error(`${cmd} failed with exit code ${res.status}`);
    }
}
export async function runDbSuperCreateUser() {
    const pgsystemuser = process.env.PGSYSTEMUSER || 'postgres'; // OS-level postgres user
    const pghost = process.env.PGHOST || '';
    const user = process.env.PGUSER;
    const pass = process.env.PGPASSWORD;
    if (!user || !pass) {
        problem('PGUSER or PGPASSWORD not defined in environment (.env)');
        return;
    }
    function hasCmd(c) {
        try {
            return spawnSync('which', [c], { stdio: 'ignore' }).status === 0;
        }
        catch {
            return false;
        }
    }
    function canNonInteractiveSudo() {
        if (!hasCmd('sudo'))
            return false;
        const r = spawnSync('sudo', ['-n', '-u', pgsystemuser, 'true'], { encoding: 'utf-8' });
        return r.status === 0;
    }
    function canNonInteractiveDoas() {
        if (!hasCmd('doas'))
            return false;
        // doas -n retorna 0 si no requiere contraseña para esa regla
        const r = spawnSync('doas', ['-n', '-u', pgsystemuser, 'true'], { encoding: 'utf-8' });
        return r.status === 0;
    }
    const interactive = process.stdin.isTTY && !process.env.CI;
    const forced = process.env.PG_ESCALATION;
    const skipSudo = !!process.env.PG_NO_SUDO || !!process.env.PG_SKIP_SUDO;
    const hostArg = (pghost && pghost !== 'localhost') ? `-h ${pghost}` : '';
    const createCmd = `createuser ${hostArg} -s ${user}`.trim();
    const alterCmd = `psql ${hostArg} -c "ALTER USER \"${user}\" WITH PASSWORD '${pass}';"`.trim();
    function runPriv(mode, cmd) {
        switch (mode) {
            case 'root-su':
                return spawnSync('su', ['-', pgsystemuser, '-c', cmd], { encoding: 'utf-8' });
            case 'doas':
                return spawnSync('doas', ['-u', pgsystemuser, 'sh', '-c', cmd], { encoding: 'utf-8' });
            case 'sudo':
                return spawnSync('sudo', ['-u', pgsystemuser, 'sh', '-c', cmd], { encoding: 'utf-8' });
            default:
                return spawnSync('sh', ['-c', cmd], { encoding: 'utf-8' });
        }
    }
    let modes = [];
    if (forced) {
        modes = [forced];
    }
    else {
        // Siempre intentar directo primero (por si hay peer trust)
        modes.push('direct');
        if (process.getuid && process.getuid() === 0) {
            modes.push('root-su');
        }
        // doas no interactivo primero
        if (canNonInteractiveDoas())
            modes.push('doas');
        // sudo no interactivo
        if (!skipSudo && canNonInteractiveSudo())
            modes.push('sudo');
        // Si seguimos sin modos privilegiados y es interactivo y no skip, permitir sudo/doas potencialmente interactivos al final
        if (!skipSudo && interactive && process.env.PG_ALLOW_INTERACTIVE_SUDO) {
            if (hasCmd('doas') && !modes.includes('doas'))
                modes.push('doas');
            if (hasCmd('sudo') && !modes.includes('sudo'))
                modes.push('sudo');
        }
    }
    // Eliminar duplicados preservando orden
    modes = modes.filter((m, i) => modes.indexOf(m) === i);
    if (modes.length === 0)
        modes = ['direct'];
    let opSuccess = false;
    let lastErr;
    for (const mode of modes) {
        info(`[db:super:createuser] intentando modo=${mode}`);
        let res = runPriv(mode, createCmd);
        if (res.status !== 0) {
            const stderr = (res.stderr || '').toString();
            if (/already exists/i.test(stderr)) {
                info(`PostgreSQL role '${user}' already exists (continuing).`);
            }
            else {
                lastErr = stderr || `Exit code ${res.status}`;
                warn(`[db:super:createuser] fallo crear usuario en modo=${mode}: ${lastErr}`);
                // Intentar siguiente modo
                // pero antes verificar si error fue autenticación -> seguir
                continue;
            }
        }
        else {
            success(`PostgreSQL superuser role created: ${user}`);
        }
        // Actualiza contraseña
        res = runPriv(mode, alterCmd);
        if (res.status !== 0) {
            const stderr = (res.stderr || '').toString();
            lastErr = stderr || `Exit code ${res.status}`;
            console.log(`[db:super:createuser] fallo establecer password en modo=${mode}: ${lastErr}`);
            continue; // probar otro modo quizá con privilegios correctos
        }
        else {
            success(`Password updated for role: ${user}`);
            opSuccess = true;
            break;
        }
    }
    if (!opSuccess) {
        problem(`[db:super:createuser] no se pudo crear/actualizar rol '${user}'. Último error: ${lastErr || 'desconocido'}`);
        problem('Sugerencia: ejecute manualmente con sudo o ajuste variables PG_ESCALATION=direct|sudo y/o configure sudo sin contraseña.');
        return; // No lanzar para que CI no quede esperando interacción
    }
    // Determine target home for .pgpass entry
    const candidateUsers = [process.env.DOAS_USER, process.env.SUDO_USER, process.env.USER].filter(Boolean);
    let targetUser = candidateUsers[0] || user;
    let home = '';
    try {
        const hres = spawnSync('sh', ['-c', `echo ~${targetUser}`], { encoding: 'utf-8' });
        if (hres.status === 0)
            home = hres.stdout.trim();
    }
    catch { }
    if (!home) {
        // Fallback to env HOME
        home = process.env.HOME || '';
    }
    if (!home) {
        warn('Could not resolve home directory to write .pgpass (skipping)');
        return;
    }
    const pgpassPath = path.join(home, '.pgpass');
    const line = `*:*:*:${user}:${pass}`;
    try {
        let needsAppend = true;
        if (fs.existsSync(pgpassPath)) {
            const existing = fs.readFileSync(pgpassPath, 'utf-8');
            if (existing.split(/\r?\n/).some(l => l.trim() === line))
                needsAppend = false;
        }
        if (needsAppend) {
            fs.appendFileSync(pgpassPath, line + os.EOL, 'utf-8');
            fs.chmodSync(pgpassPath, 0o600);
            success(`Added credentials to ${pgpassPath}`);
        }
        else {
            info(`Credentials already present in ${pgpassPath}`);
        }
    }
    catch (e) {
        warn(`Warning: could not update ${pgpassPath}: ${e.message}`);
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
import { cliKey } from '../i18n.js';
// Structure dump to plain SQL: truth = DB -> db/structure.sql
export async function runDbStructureDump() {
    const cfg = pgConfig();
    const env = buildEnvArgs(cfg);
    const dbDir = path.join(process.cwd(), 'db');
    fs.mkdirSync(dbDir, { recursive: true });
    const outFile = path.join(dbDir, 'structure.sql');
    console.log('[structure:dump]', await cliKey('structure.dump_start'));
    // pg_dump options: no owner, schema only, no privileges
    const args = [
        '--schema-only',
        '--no-owner',
        '--no-privileges',
        cfg.database
    ];
    if (cfg.host) {
        args.unshift('-h', cfg.host);
    }
    if (cfg.port) {
        args.unshift('-p', cfg.port);
    }
    if (cfg.user) {
        args.unshift('-U', cfg.user);
    }
    // Usamos spawnSync con pipe para capturar y escribir archivo
    const res = spawnSync('pg_dump', args, { env });
    if (res.status !== 0) {
        problem('[structure:dump] ' + await cliKey('structure.dump_error'));
        process.exit(res.status ?? 1);
    }
    fs.writeFileSync(outFile, res.stdout);
    success('[structure:dump] ' + await cliKey('structure.dump_written'));
    if (process.exitCode == null)
        process.exitCode = 0;
}
// Load structure from db/structure.sql: recreate DB (or ensure) and apply
export async function runDbStructureLoad() {
    const cfg = pgConfig();
    const env = buildEnvArgs(cfg);
    const file = path.join(process.cwd(), 'db', 'structure.sql');
    if (!fs.existsSync(file)) {
        problem('[structure:load] ' + await cliKey('structure.load_missing'));
        process.exit(1);
    }
    info('[structure:load] ' + await cliKey('structure.load_ensuring'));
    // Try a simple connection listing tables; if it fails with 3D000 create
    let needCreate = false;
    try {
        const probe = spawnSync('psql', [...psqlArgs(cfg), '-c', 'SELECT 1', cfg.database], { env });
        if (probe.status !== 0) {
            needCreate = true;
        }
    }
    catch {
        needCreate = true;
    }
    if (needCreate) {
        info('[structure:load] ' + await cliKey('structure.load_creating_db', { db: cfg.database }));
        const c = spawnSync('createdb', [cfg.database], { env });
        if (c.status !== 0) {
            problem('[structure:load] ' + await cliKey('structure.load_create_failed'));
            process.exit(c.status ?? 1);
        }
    }
    info('[structure:load] ' + await cliKey('structure.load_applying'));
    const apply = spawnSync('psql', [...psqlArgs(cfg), '-v', 'ON_ERROR_STOP=1', '-f', file, cfg.database], { stdio: 'inherit', env });
    if (apply.status !== 0) {
        problem('[structure:load] ' + await cliKey('structure.load_apply_error'));
        process.exit(apply.status ?? 1);
    }
    success('[structure:load] ' + await cliKey('structure.load_applied'));
    if (process.exitCode == null)
        process.exitCode = 0;
}
// Minimal migrations: numbered files in db/migrate/*.sql
function migrationsDir() {
    return path.join(process.cwd(), 'db', 'migrate');
}
function ensureSchemaMigrations(cfg, env) {
    const sql = "CREATE TABLE IF NOT EXISTS schema_migrations (version varchar(255) PRIMARY KEY);";
    run('psql', [...psqlArgs(cfg), '-c', sql, cfg.database], env);
}
function appliedMigrations(cfg, env) {
    const tmp = spawnSync('psql', [...psqlArgs(cfg), '-t', '-c', 'SELECT version FROM schema_migrations', cfg.database], { env, encoding: 'utf-8' });
    if (tmp.status !== 0)
        return new Set();
    return new Set(tmp.stdout.split(/\s+/).map(s => s.trim()).filter(s => s.length > 0));
}
function recordMigration(cfg, env, version) {
    run('psql', [...psqlArgs(cfg), '-c', `INSERT INTO schema_migrations(version) VALUES ('${version}') ON CONFLICT DO NOTHING`, cfg.database], env);
}
function deleteMigration(cfg, env, version) {
    run('psql', [...psqlArgs(cfg), '-c', `DELETE FROM schema_migrations WHERE version='${version}'`, cfg.database], env);
}
export async function runDbMigMake(m) {
    const kyselyBin = path.join(process.cwd(), 'node_modules', '.bin', 'kysely');
    if (!fs.existsSync(kyselyBin)) {
        problem('[db:mig:make] `kysely` binary not found. Is it installed in your project?');
        process.exit(1);
    }
    const res = spawnSync(kyselyBin, ['migrate:make', m], { stdio: 'inherit' });
    if (res.status !== 0) {
        problem(`[db:mig:make] Kysely migrate:make failed with exit code ${res.status}`);
        process.exit(res.status ?? 1);
    }
    success(`[db:mig:make] Migration file created. Please edit the new file in db/migrations.`);
}
// New implementation based on Kysely Migrator
export async function runDbMigrate() {
    // Fuentes de migraciones:
    // 1. Core engine migrations: package @pasosdejesus/msipn-core
    // 2. Application migrations (cwd)/db/migrations
    // 3. Future: other descendant engines (names starting @pasosdejesus/msipn-*)
    const sources = [];
    // Resolve core package location: assume installed via workspace and present in node_modules or relative path
    try {
        // Buscar node_modules/@pasosdejesus/msipn-core/package.json relativo al cwd ascendiendo.
        let dir = process.cwd();
        let corePkgJson;
        for (let i = 0; i < 6 && dir; i++) {
            const candidate = path.join(dir, 'node_modules', '@pasosdejesus', 'msipn-core', 'package.json');
            if (fs.existsSync(candidate)) {
                corePkgJson = candidate;
                break;
            }
            const parent = path.dirname(dir);
            if (parent === dir)
                break;
            dir = parent;
        }
        if (corePkgJson) {
            const coreRoot = path.dirname(corePkgJson);
            // Migraciones compiladas en dist/db/migrations
            const coreMigDist = path.join(coreRoot, 'dist', 'db', 'migrations');
            if (fs.existsSync(coreMigDist)) {
                info('[migrate] ' + await cliKey('migrate.total_sources') + ' ' + coreMigDist);
                sources.push(coreMigDist);
            }
            else {
                warn('[migrate] ' + await cliKey('migrate.error_reading', { folder: coreMigDist, error: 'missing' }));
            }
        }
    }
    catch (e) {
        warn('[migrate] ' + await cliKey('migrate.error_reading', { folder: 'msipn-core', error: e.message }));
    }
    const appMig = path.join(process.cwd(), 'db', 'migrations');
    if (fs.existsSync(appMig)) {
        info('[migrate] ' + await cliKey('migrate.reading_folder', { folder: appMig }));
        sources.push(appMig);
    }
    else {
        info('[migrate] ' + await cliKey('migrate.no_folders'));
    }
    // TODO: detect other engines: could inspect node_modules/@pasosdejesus/*/src/db/migrations
    // For now only core + app.
    try {
        if (sources.length === 0) {
            info('[migrate] ' + await cliKey('migrate.no_folders'));
            return;
        }
        // Verificar conectividad y crear base si falta
        const cfg = pgConfig();
        const env = buildEnvArgs(cfg);
        const probe = spawnSync('psql', [...psqlArgs(cfg), '-c', 'SELECT 1', cfg.database], { env });
        if (probe.status !== 0) {
            info('[migrate] ' + await cliKey('migrate.creating_db', { db: cfg.database }));
            const createdb = spawnSync('createdb', [cfg.database], { env });
            if (createdb.status !== 0) {
                problem('[migrate] ' + await cliKey('migrate.create_failed'));
                process.exit(createdb.status ?? 1);
            }
        }
        const { Kysely, PostgresDialect, FileMigrationProvider, Migrator, sql } = await dynamicLoadKysely();
        info('[migrate] ' + await cliKey('migrate.instantiating'));
        const db = await buildKyselyInstance(Kysely, PostgresDialect);
        // Eliminado: creación manual de tablas de tracking (Kysely las crea/gestiona). Evitamos inconsistencias vs. esquema esperado.
        info('[migrate] ' + await cliKey('migrate.total_sources') + ' ' + sources);
        const allMigrations = {};
        for (const folder of sources) {
            info('[migrate] ' + await cliKey('migrate.reading_folder', { folder }));
            const provider = new FileMigrationProvider({ fs: fs.promises, path, migrationFolder: folder });
            try {
                const migs = await provider.getMigrations();
                const keys = Object.keys(migs);
                info('[migrate] ' + await cliKey('migrate.source_contains', { folder, list: keys.join(', ') }));
                for (const k of keys) {
                    if (allMigrations[k]) {
                        warn('[migrate] ' + await cliKey('migrate.conflict', { name: k }));
                        continue;
                    }
                    allMigrations[k] = migs[k];
                }
            }
            catch (e) {
                problem('[migrate] ' + await cliKey('migrate.error_reading', { folder, error: e.message }));
            }
        }
        const finalProvider = { getMigrations: async () => allMigrations };
        info('[migrate] ' + await cliKey('migrate.final_map', { list: Object.keys(allMigrations).join(', ') }));
        if (Object.keys(allMigrations).length === 0) {
            info('[migrate] ' + await cliKey('migrate.no_files'));
        }
        const migrator = new Migrator({ db, provider: finalProvider });
        info('[migrate] ' + await cliKey('migrate.executing'));
        const { error, results } = await migrator.migrateToLatest();
        if (results) {
            for (const r of results) {
                if (r.status === 'Success') {
                    success('[migrate] ' + await cliKey('migrate.applied', { name: r.migrationName }));
                }
                else if (r.status === 'Error') {
                    problem('[migrate] ' + await cliKey('migrate.error_in', { name: r.migrationName }));
                }
            }
        }
        if (error) {
            problem('[migrate] ' + await cliKey('migrate.failure') + ' ' + error);
            await db.destroy();
            process.exit(1);
        }
        // Post-migrate hook: attempt to run kysely-codegen if available in app (non-fatal if missing)
        try {
            const appCwd = process.cwd();
            const codegenBin = path.join(appCwd, 'node_modules', '.bin', 'kysely-codegen');
            const dbDir = path.join(appCwd, 'db');
            if (fs.existsSync(codegenBin) && fs.existsSync(dbDir)) {
                const outFile = path.join(dbDir, 'db.d.ts');
                info('[migrate] ' + await cliKey('migrate.post_codegen', { file: outFile }));
                const cg = spawnSync(codegenBin, ['--out-file', outFile], { stdio: 'inherit', env: process.env });
                if (cg.status !== 0) {
                    warn('[migrate] ' + await cliKey('migrate.codegen_warn', { code: cg.status }));
                }
                else {
                    success('[migrate] ' + await cliKey('migrate.codegen_types', { file: outFile }));
                }
            }
            else {
                info('[migrate] ' + await cliKey('migrate.codegen_skip'));
            }
        }
        catch (e) {
            warn('[migrate] ' + await cliKey('migrate.codegen_error', { error: e.message }));
        }
        await db.destroy();
    }
    catch (e) {
        problem('[migrate] ' + await cliKey('migrate.unexpected', { error: e.message }));
        process.exit(1);
    }
}
export async function runDbRollback() {
    const kyselyBin = path.join(process.cwd(), 'node_modules', '.bin', 'kysely');
    const codegenBin = path.join(process.cwd(), 'node_modules', '.bin', 'kysely-codegen');
    if (!fs.existsSync(kyselyBin)) {
        problem('[db:rollback] `kysely` binary not found. ' +
            'Is it installed in your project?');
        process.exit(1);
    }
    if (!fs.existsSync(codegenBin)) {
        problem('[db:rollback] `kysely-codegen` binary not found. ' +
            'Is it installed in your project?');
        process.exit(1);
    }
    try {
        info('[db:rollback] Executing: ./node_modules/.bin/kysely migrate:down');
        const rollback = spawnSync(kyselyBin, ['migrate:down'], { stdio: 'inherit' });
        if (rollback.status !== 0) {
            problem(`[db:rollback] Kysely migrate:down failed ` +
                `with exit code ${rollback.status}`);
            process.exit(rollback.status ?? 1);
        }
        success('[db:rollback] Migration successfully rolled back.');
        info('[db:rollback] Executing: ./node_modules/.bin/kysely-codegen --out-file ./db/db.d.ts');
        const codegen = spawnSync(codegenBin, ['--out-file', './db/db.d.ts'], { stdio: 'inherit' });
        if (codegen.status !== 0) {
            problem(`[db:rollback] kysely-codegen failed ` +
                `with exit code ${codegen.status}`);
            process.exit(codegen.status ?? 1);
        }
        success('[db:rollback] Types generated successfully.');
    }
    catch (e) {
        problem(`[db:rollback] An unexpected error occurred: ` +
            `${e.message}`);
        process.exit(1);
    }
}
async function dynamicLoadKysely() {
    try {
        // @ts-ignore dependencia dinámica presente en la app que usa el CLI
        const mod = await import('kysely');
        return mod;
    }
    catch (e) {
        problem('[kysely] ' + await cliKey('kysely.load_error'));
        throw e;
    }
}
async function buildKyselyInstance(Kysely, PostgresDialect) {
    let Pool;
    try {
        ({ Pool } = await import('pg'));
    }
    catch (e) {
        problem('[kysely] ' + await cliKey('kysely.pg_import_error'));
        throw e;
    }
    const pool = new Pool({
        database: process.env.PGDATABASE,
        host: process.env.PGHOST,
        port: process.env.PGPORT ? parseInt(process.env.PGPORT, 10) : undefined,
        user: process.env.PGUSER,
        password: process.env.PGPASSWORD
    });
    return new Kysely({
        dialect: new PostgresDialect({ pool })
    });
}
export async function runDbSeed() {
    const cfg = pgConfig();
    const env = buildEnvArgs(cfg);
    const seedSql = path.join(process.cwd(), 'db', 'seeds.sql');
    if (fs.existsSync(seedSql)) {
        run('psql', [...psqlArgs(cfg), '-f', seedSql, cfg.database], env);
        success('[seed] ' + await cliKey('seed.applied'));
    }
    else {
        info('[seed] ' + await cliKey('seed.missing'));
    }
}
export async function runDbConsole() {
    const cfg = pgConfig();
    if (!cfg.database) {
        problem('[console] ' + await cliKey('console.pgdatabase_missing'));
        return;
    }
    const env = buildEnvArgs(cfg);
    // Abrir psql interactivo heredando stdio
    const args = [...psqlArgs(cfg), cfg.database];
    const res = spawnSync('psql', args, { stdio: 'inherit', env });
    if (res.status !== 0) {
        problem('[console] ' + await cliKey('console.psql_exit_code', { code: res.status }));
    }
}
