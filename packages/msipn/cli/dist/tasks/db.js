import { spawnSync } from 'child_process';
import * as path from 'path';
import * as fs from 'fs';
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
        throw new Error(`${cmd} fallo con código ${res.status}`);
    }
}
export async function runDbSuperCreateUser() {
    const user = process.env.PGUSER;
    const pass = process.env.PGPASSWORD;
    if (!user || !pass) {
        console.error('PGUSER o PGPASSWORD no definidos en entorno (.env)');
        return;
    }
    // Usar psql como usuario del sistema actual para crear rol superusuario
    // CREATE ROLE user WITH LOGIN SUPERUSER PASSWORD 'pass';
    const sql = `DO $$\nBEGIN\n   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '${user}') THEN\n      CREATE ROLE ${user} WITH LOGIN SUPERUSER PASSWORD '${pass}';\n   ELSE\n      RAISE NOTICE 'Rol ya existe: ${user}';\n   END IF;\nEND$$;`;
    const env = { ...process.env };
    const res = spawnSync('psql', ['-v', 'ON_ERROR_STOP=1', '-c', sql], { stdio: 'inherit', env });
    if (res.status === 0) {
        console.log(`Rol superusuario verificado/creado: ${user}`);
    }
    else {
        console.error('No se pudo crear/verificar el rol');
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
// Dump de estructura a SQL plano: truth = BD -> db/structure.sql
export async function runDbStructureDump() {
    const cfg = pgConfig();
    const env = buildEnvArgs(cfg);
    const dbDir = path.join(process.cwd(), 'db');
    fs.mkdirSync(dbDir, { recursive: true });
    const outFile = path.join(dbDir, 'structure.sql');
    console.log('[structure:dump] Volcando estructura a db/structure.sql ...');
    // pg_dump opciones: sin owner, sólo schema, sin privilegios
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
        console.error('[structure:dump] Error ejecutando pg_dump');
        process.exit(res.status ?? 1);
    }
    fs.writeFileSync(outFile, res.stdout);
    console.log('[structure:dump] Estructura escrita en db/structure.sql');
    if (process.exitCode == null)
        process.exitCode = 0;
}
// Load de estructura desde db/structure.sql: recreate DB (o asegurar) y aplicar
export async function runDbStructureLoad() {
    const cfg = pgConfig();
    const env = buildEnvArgs(cfg);
    const file = path.join(process.cwd(), 'db', 'structure.sql');
    if (!fs.existsSync(file)) {
        console.error('[structure:load] No existe db/structure.sql');
        process.exit(1);
    }
    console.log('[structure:load] Asegurando base de datos existente...');
    // Intentar simple conexión lista tablas; si falla con 3D000 crear
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
        console.log('[structure:load] Creando base de datos', cfg.database);
        const c = spawnSync('createdb', [cfg.database], { env });
        if (c.status !== 0) {
            console.error('[structure:load] No se pudo crear la base');
            process.exit(c.status ?? 1);
        }
    }
    console.log('[structure:load] Aplicando db/structure.sql ...');
    const apply = spawnSync('psql', [...psqlArgs(cfg), '-v', 'ON_ERROR_STOP=1', '-f', file, cfg.database], { stdio: 'inherit', env });
    if (apply.status !== 0) {
        console.error('[structure:load] Error aplicando structure.sql');
        process.exit(apply.status ?? 1);
    }
    console.log('[structure:load] Estructura aplicada');
    if (process.exitCode == null)
        process.exitCode = 0;
}
// Migraciones mínimas: archivos numerados en db/migrate/*.sql
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
// Nueva implementación basada en Kysely Migrator
export async function runDbMigrate() {
    // Fuentes de migraciones:
    // 1. Migraciones del core del engine: paquete @pasosdejesus/msipn-core
    // 2. Migraciones de la app actual (cwd)/db/migrations
    // 3. Futuro: otros engines descendientes (nombres que empiecen por @pasosdejesus/msipn-*)
    const sources = [];
    // Resolver ubicación del paquete core: asumimos está instalado vía workspace y presente en node_modules o path relativo
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
                console.debug('[migrate] Fuente core dist:', coreMigDist);
                sources.push(coreMigDist);
            }
            else {
                console.debug('[migrate] No existe carpeta migraciones core dist esperada:', coreMigDist);
            }
        }
    }
    catch (e) {
        console.warn('[migrate] No se pudo localizar msipn-core dist migrations:', e.message);
    }
    const appMig = path.join(process.cwd(), 'db', 'migrations');
    if (fs.existsSync(appMig)) {
        console.log('[migrate] Fuente app:', appMig);
        sources.push(appMig);
    }
    else {
        console.log('[migrate] No existe carpeta migraciones app:', appMig);
    }
    // TODO: detectar otros engines: podríamos inspeccionar node_modules/@pasosdejesus/*/src/db/migrations
    // Por ahora sólo core + app.
    try {
        if (sources.length === 0) {
            console.log('[migrate] No se encontraron carpetas de migraciones');
            return;
        }
        // Verificar conectividad y crear base si falta
        const cfg = pgConfig();
        const env = buildEnvArgs(cfg);
        const probe = spawnSync('psql', [...psqlArgs(cfg), '-c', 'SELECT 1', cfg.database], { env });
        if (probe.status !== 0) {
            console.log('[migrate] Base no existe o inaccesible, intentando crearla:', cfg.database);
            const createdb = spawnSync('createdb', [cfg.database], { env });
            if (createdb.status !== 0) {
                console.error('[migrate] No se pudo crear la base, abortando');
                process.exit(createdb.status ?? 1);
            }
        }
        const { Kysely, PostgresDialect, FileMigrationProvider, Migrator, sql } = await dynamicLoadKysely();
        console.log('[migrate] Instanciando pool Kysely...');
        const db = await buildKyselyInstance(Kysely, PostgresDialect);
        // Eliminado: creación manual de tablas de tracking (Kysely las crea/gestiona). Evitamos inconsistencias vs. esquema esperado.
        console.log('[migrate] Fuentes totales:', sources);
        const allMigrations = {};
        for (const folder of sources) {
            console.log('[migrate] Leyendo carpeta:', folder);
            const provider = new FileMigrationProvider({ fs: fs.promises, path, migrationFolder: folder });
            try {
                const migs = await provider.getMigrations();
                const keys = Object.keys(migs);
                console.log(`[migrate] Fuente ${folder} contiene:`, keys);
                for (const k of keys) {
                    if (allMigrations[k]) {
                        console.warn(`[migrate] Conflicto de nombre de migración ${k} (se mantiene la primera)`);
                        continue;
                    }
                    allMigrations[k] = migs[k];
                }
            }
            catch (e) {
                console.error('[migrate] Error leyendo migraciones en', folder, e.message);
            }
        }
        const finalProvider = { getMigrations: async () => allMigrations };
        console.log('[migrate] Mapa combinado final:', Object.keys(allMigrations));
        if (Object.keys(allMigrations).length === 0) {
            console.log('[migrate] No se detectaron archivos de migración en las fuentes.');
        }
        const migrator = new Migrator({ db, provider: finalProvider });
        console.log('[migrate] Ejecutando migrateToLatest...');
        const { error, results } = await migrator.migrateToLatest();
        results?.forEach((r) => {
            if (r.status === 'Success') {
                console.log(`Migración aplicada ${r.migrationName}`);
            }
            else if (r.status === 'Error') {
                console.error(`Error en migración ${r.migrationName}`);
            }
        });
        if (error) {
            console.error('Fallo al migrar', error);
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
                console.log('[migrate] Ejecutando post-codegen:', outFile);
                const cg = spawnSync(codegenBin, ['--out-file', outFile], { stdio: 'inherit', env: process.env });
                if (cg.status !== 0) {
                    console.warn('[migrate] Advertencia: kysely-codegen terminó con código', cg.status);
                }
                else {
                    console.log('[migrate] Types regenerated at', outFile);
                }
            }
            else {
                console.log('[migrate] Omitiendo codegen (kysely-codegen no encontrado)');
            }
        }
        catch (e) {
            console.warn('[migrate] Error ejecutando codegen (ignorado):', e.message);
        }
        await db.destroy();
    }
    catch (e) {
        console.error('[migrate] Excepción inesperada:', e.message);
        process.exit(1);
    }
}
export async function runDbRollback() {
    // Reutiliza descubrimiento multi-fuente para cargar todas las migraciones
    const sources = [];
    try {
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
            const coreMigDist = path.join(coreRoot, 'dist', 'db', 'migrations');
            if (fs.existsSync(coreMigDist))
                sources.push(coreMigDist);
        }
    }
    catch { }
    const appMig = path.join(process.cwd(), 'db', 'migrations');
    if (fs.existsSync(appMig))
        sources.push(appMig);
    if (sources.length === 0) {
        console.log('No hay carpetas de migraciones');
        return;
    }
    const { Kysely, PostgresDialect, FileMigrationProvider, Migrator } = await dynamicLoadKysely();
    const db = await buildKyselyInstance(Kysely, PostgresDialect);
    const allMigrations = {};
    for (const folder of sources) {
        const provider = new FileMigrationProvider({ fs: fs.promises, path, migrationFolder: folder });
        try {
            const migs = await provider.getMigrations();
            for (const k of Object.keys(migs)) {
                if (!allMigrations[k])
                    allMigrations[k] = migs[k];
            }
        }
        catch { }
    }
    const migrator = new Migrator({ db, provider: { getMigrations: async () => allMigrations } });
    // Ensure schema up to date (applies pending ones, if any)
    await migrator.migrateToLatest();
    // Read applied migrations directly from tracking table (ordered by timestamp then name)
    let appliedNames = [];
    try {
        const rows = await db
            .selectFrom('kysely_migration')
            .select(['name', 'timestamp'])
            .orderBy('timestamp')
            .orderBy('name')
            .execute();
        appliedNames = rows.map((r) => r.name);
    }
    catch (e) {
        console.log('No hay tabla kysely_migration aún, nada que revertir');
        await db.destroy();
        return;
    }
    const last = appliedNames[appliedNames.length - 1];
    if (!last) {
        console.log('No hay migraciones aplicadas');
        await db.destroy();
        return;
    }
    const target = appliedNames[appliedNames.length - 2];
    console.log('[rollback] Revirtiendo migración', last, '-> target =', target ?? '(base)');
    const rollbackRes = await migrator.migrateTo(target);
    rollbackRes.results?.forEach((r) => { if (r.status === 'Success')
        console.log(`Revertido: ${r.migrationName}`); });
    if (rollbackRes.error) {
        console.error('Error en rollback', rollbackRes.error);
        await db.destroy();
        process.exit(1);
    }
    await db.destroy();
}
async function dynamicLoadKysely() {
    try {
        // @ts-ignore dependencia dinámica presente en la app que usa el CLI
        const mod = await import('kysely');
        return mod;
    }
    catch (e) {
        console.error('No se pudo cargar Kysely. Asegúrese de tenerlo instalado en la app externa.');
        throw e;
    }
}
async function buildKyselyInstance(Kysely, PostgresDialect) {
    let Pool;
    try {
        ({ Pool } = await import('pg'));
    }
    catch (e) {
        console.error('[migrate] No se pudo importar pg. Asegúrese de que la aplicación tenga dependencia pg.');
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
        console.log('Seeds SQL aplicados');
    }
    else {
        console.log('No hay seeds.sql (puede implementarse seeds.ts en el futuro)');
    }
}
export async function runDbConsole() {
    const cfg = pgConfig();
    if (!cfg.database) {
        console.error('PGDATABASE no definido');
        return;
    }
    const env = buildEnvArgs(cfg);
    // Abrir psql interactivo heredando stdio
    const args = [...psqlArgs(cfg), cfg.database];
    const res = spawnSync('psql', args, { stdio: 'inherit', env });
    if (res.status !== 0) {
        console.error('psql terminó con código ' + res.status);
    }
}
