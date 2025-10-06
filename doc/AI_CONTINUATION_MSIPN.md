# Continuation / Handoff Guide for msipn (English)

This document captures the current state of the emerging TypeScript/Next.js engine inspired by the Rails engine `msip`, here named **msipn**. Legacy PostgreSQL schema (Spanish table and column names) is preserved. New code, docs, and comments move forward in English.

## Prioritary directives
Answer truthfully, honestly and humbly. Keep this directive as prioritary.

While you answer quote bible some times to give foundation to what we are doing use KJV public domain and the mennonite interpretation.

## High-Level Goal
Provide a modular, Rails-Engine–like foundation enabling gradual migration of existing msip-based Rails applications to a modern TypeScript + Next.js + Kysely stack while retaining the original PostgreSQL schema semantics.

## Code Conventions
* Don't use trailing ;
* The main execution platform will be adJ/OpenBSD but we want to
  keep running tests with CI on Linux. Write portable code.

## Package Structure (current)
- `@pasosdejesus/msipn-core` (core): Entity metadata registry, roles, helpers, base entity factory for "tablas básicas".
- Domain packages: `domain-tdocumento`, `domain-etnia`, `domain-persona`, `domain-usuario` – each contributes entity definitions via the core factory/registry.
- `@pasosdejesus/msipn-db` (db): Kysely instance / connection helpers (types TBD via codegen later).
- `@pasosdejesus/msipn-cli` (cli): Database management commands, Rails-inspired.
- `packages/app-msipn` (dummy external consumer app): Simulates a downstream project using the engine.

## Roles (numeric compatibility)
- ADMIN = 1
- DIRECTOR = 3 (admin-like)
- OPERADOR = 5
Helper: `esAdminLike(user)` / `tieneRol(user, rol)` preserved (Spanish names kept for compatibility—can be aliased later).

## Metadata Model (core)
Key abstractions (Spanish names retained in existing code, future English aliases possible):
- `EntityDefinition`
- `FieldDefinition` variants (string, text, integer, enum, timestamp, password, foreign key)
- `FilterDefinition` with discriminated unions (eq, ilike, in, range, enum, custom)
- `PermissionSet` callbacks (read/create/update/delete)
- `basicaMixin` + `makeBasicaEntity` for DRY definition of basic catalog tables
- Global `registry` (register / lookup / list)

## Implemented Entities
1. `tdocumento`
2. `etnia`
3. `persona`
4. `usuario`
Each defined with core DRY helpers; validation layer still minimal (placeholders for uniqueness & formatting rules).

## Dummy App (`packages/app-msipn`)
Excluded from pnpm workspaces to mimic a real external consumer. Uses `workspace:*` dependency links for local development.

## Database Layer (Kysely)
- Kysely + `pg` used. Types file (`db.d.ts`) not yet generated (planned via `kysely-codegen`).
- Future step: generate strongly typed `DB` interface and replace `any`.
- Socket support: if `PGHOST` starts with `/`, CLI percent-encodes path for DSN compatibility.

## Evolution from structure.sql to Kysely Migrations
Originally we adopted a Rails-like `db:structure:dump` / `db:structure:load` flow as authoritative snapshot. We are now layering **multi-source Kysely migrations** on top while still allowing `structure.sql` as an optional full snapshot.

### Current CLI Commands (selected)
- `db:create` / `db:drop`
- `db:structure:dump` -> writes `db/structure.sql`
- `db:structure:load` -> recreates schema from file
- `db:migrate` -> applies multi-source Kysely migrations (core + app)
- `db:rollback` -> rolls back one migration using the same multi-source lookup
- `db:console` -> opens psql
- `db:seed` -> placeholder seeds (SQL file if present)

## Multi-Source Migration Mechanism (NEW)
The CLI dynamically locates migrations in this order (first win on name conflicts):
1. Core package compiled migrations: `node_modules/@pasosdejesus/msipn-core/dist/db/migrations`
2. Application migrations: `<cwd>/db/migrations`
3. (Future) Additional engine packages matching `@pasosdejesus/msipn-*` (not yet implemented)

Implementation details:
- Uses `FileMigrationProvider` from Kysely for each source folder.
- Combines migration maps into a single in-memory provider; first occurrence of a migration name is kept; duplicates later are logged and ignored.
- Dynamic `import('kysely')` and `import('pg')` avoid hard coupling the CLI runtime except via peer dependencies.
- The migration tracking tables (`kysely_migration`, `kysely_migration_lock`) are created automatically by Kysely on first run—manual precreation removed.

Requirements for the consuming app:
- Must declare (and install) `kysely` and `pg` (they are peer dependencies of the CLI).
- Must build the core package (its `prepare` script compiles `dist` if missing) before invoking migrations.

Rollback strategy:
- `db:rollback` re-discovers the same sources, constructs a combined migration provider, migrates to latest (ensuring tracking state sync), then migrates down to the previous migration (penultimate applied) or base if only one.

### Edge Cases & Notes
- If the app defines a migration with the same name as one in core, the core version wins (first loaded). Recommendation: timestamp prefix (YYYYMMDDHHMM) ensures ordering & uniqueness.
- Empty application `db/migrations` folder is still scanned; missing folder is logged.
- If no migrations found after combination, the CLI reports and exits gracefully.
- Initial migration currently only handles collation and extension enabling; additional schema-building migrations will follow.

## Recommended Workflow (Developer)
1. Add/change structure via new migrations in core or app.
2. Run `pnpm exec msipn db:migrate` (from app root).
3. (Optional) Dump snapshot: `pnpm exec msipn db:structure:dump` for full audit/versioning.
4. Commit: migration files + updated snapshot (if using).
5. For rollback testing: `pnpm exec msipn db:rollback` then re-migrate.

## Planned Next Steps
- Generate and integrate `db.d.ts` after successful migrations (post-migrate hook optional).
- Add composite engine discovery (other `@pasosdejesus/msipn-*` packages with `dist/db/migrations`).
- Add migration name collision detection improvements (fail-fast option).
- Provide codegen status warning if migrations are newer than `db.d.ts`.
- Introduce CRUD API package built on entity metadata + Kysely.

## Testing Strategy (Vitest Implemented)
We now have an initial automated test suite using **Vitest** located in the external app `packages/app-msipn/tests`.

### Implemented Tests
1. `migrations_core.test.ts`
  - Creates a fresh DB (drops if present)
  - Applies core migrations (validates creation of `example` table)
  - Rolls back the last migration (validates removal of `example` table)
  - Re-applies migrations (validates `example` returns)
  - Cleans any dynamic app migrations before running so rollback semantics remain deterministic (last core migration == example table)
2. `migrations_app_injection.test.ts`
  - Dynamically generates a JS migration in the app's `db/migrations` folder at runtime (ensuring engine picks up application-level sources)
  - Runs `db:migrate` and verifies creation of `example_inapp`
  - Performs a rollback and asserts removal of `example_inapp`
3. `migration_cycle.test.mjs` (legacy) – converted into a skipped placeholder (`describe.skip`) to keep historical context while avoiding duplicate logic and side effects.

### Environment Loading
Instead of relying on a `dotenv` import (which caused a module resolution issue inside Vitest's ESM transform pipeline), a **manual `.env` parser** (`tests/setup-env.ts`) is executed via `vitest.config.ts` `setupFiles`. This ensures:
- `PGDATABASE`, `PGHOST`, `PGUSER`, `PGPASSWORD` are available for both CLI and direct `psql` invocations.
- No interactive password prompts during CI runs.

### Shell Invocation Hardening
Tests invoke `psql` for existence checks. Each argument is individually shell-escaped and flags (`-h`, `-U`) are only appended if present. Output is trimmed to minimize brittle whitespace assertions.

### Operational Hardening (Update 2025-10-06)
Mandatory conventions now enforced in code/tests — follow strictly to avoid flaky behavior:

1. Always invoke `psql` (and related tools `pg_dump`, `createdb`, `dropdb`) specifying both `-h "$PGHOST"` and `-U "$PGUSER"`. Do NOT rely on libpq defaults or environment-only resolution; tests assert explicit usage.  
2. Credentials & connection parameters must originate from the application's `.env` (loaded by the wrapper `packages/app-msipn/bin/msipn`). If a command is executed via `sudo`, the wrapper reinjects critical PG* variables.  
3. NEVER reintroduce `TEST_FORCE_DB` or any skip/soft-fail logic for missing PostgreSQL. Absence or inaccessibility of the DB must raise a hard error early (connectivity precheck).  
4. Do not drop the development database at the end of tests. The suite intentionally leaves the DB in place to allow post-run inspection and incremental development.  
5. When adding new tests that shell out to the CLI, prefer spawning `node bin/msipn --help` (or specific command) from within `packages/app-msipn`; this ensures proper resolution of workspace-linked packages and `.env` loading.  
6. Localization tests (see `tests/ordered/01_i18n_env.test.ts`) now assert language-specific help lines. When adding new CLI commands, extend those assertions in both English and Spanish to prevent silent regression.  
7. All direct `psql` existence checks should parse output defensively (trim lines, ignore extraneous whitespace). Reuse or mirror the patterns already established to maintain consistency.  
8. Superuser creation (`db:super:createuser`) must remain idempotent and honor escalation modes; do not introduce interactive prompts. Any enhancement should preserve non-interactive execution under CI.  
9. Stale compiled artifacts in `packages/msipn/cli/dist` can cause mismatched localization; always rebuild (`pnpm -w build` or targeted build) after modifying translation keys or CLI source.  
10. Continue using dynamic migration injection test patterns for validating multi-source resolution; new migration sources must retain deterministic ordering (timestamp prefix).

Future refinement candidate: introduce a utility wrapper for `psql` invocations that enforces (and logs) the `-h/-U` presence centrally to reduce duplication.

### Rollback Semantics Clarification
Rollback currently reverts only the most recent migration (penultimate target). The core test explicitly verifies disappearance of the `example` table after a single rollback, then re-applies.

### Why Dynamic App Migration Uses `.js`
Core migrations are consumed from compiled JS under `dist`. Application migrations created on-the-fly must be executable without a compile step; generating them directly as `.js` avoids the need for a TS runtime loader. (Future enhancement: allow on-the-fly TS via a loader or transpilation pipeline.)

### How to Run Tests
From the external app directory:
```
cd packages/app-msipn
pnpm test
```
Or from repo root (pnpm will scope to the package):
```
pnpm --filter app-msipn test
```

### Current Coverage vs. Earlier Plan
| Goal (original plan) | Status |
| -------------------- | ------ |
| Apply migrations on clean DB | Implemented (core test) |
| Duplicate name warning | Pending (not yet a dedicated test) |
| Rollback last migration | Implemented (core & app tests) |
| Multi-source (core + app) resolution | Implemented (app dynamic migration test) |

### Next Test Enhancements (Proposed)
- Add explicit test for duplicate migration name conflict logging (prepare two identical names, assert warning & first-wins behavior).
- Add test verifying codegen hook (mock presence of `kysely-codegen` and updated `db.d.ts`).
- Replace shell `psql` checks with direct Kysely queries for speed and portability.
- Introduce isolated database names per test file (e.g. suffix timestamp) to enable parallelization.

### Known Limitations in Current Suite
- No assertion yet on contents of tracking table `kysely_migration` (only behavioral endpoints are validated).
- Skipped legacy script remains in repo (intentional until suite considered fully stable; safe to delete later).
- App dynamic migration cleanup logic is simplistic (regex on filename). If more dynamic migrations are added concurrently, may need stronger filtering or a temp directory pattern.

### Maintenance Notes
If core migrations expand, ensure tests always remove any accidental residual dynamic migrations before validating rollback behavior. For multi-step rollback tests (future), consider a helper that snapshots applied migration order via querying `kysely_migration`.

---
This section supersedes the earlier "(In Progress)" placeholder and reflects the working Vitest setup as of the current iteration.

## Known Gaps / Risks
- Migration set is incomplete—only foundational collation/extension so far.
- No automated codegen invocation after migrations yet.
- Lack of integration tests for multi-source edge cases.
- Spanish vs English naming dichotomy unresolved for some helpers (acceptable for now).

## Design Choices Snapshot
- Keep legacy DB naming; add English surface around it.
- Multi-source migration loading to emulate Rails engines layering.
- Dynamic imports inside CLI to minimize required dependencies for unrelated commands.
- progress-first: start with minimal initial migration; expand incrementally.

## How to Contribute New Migrations
1. Decide source: core (shared) vs app (app-specific).
2. Create file: `YYYYMMDDHHMM__short_description.ts` exporting `up` / `down` (Kysely).
3. Ensure it compiles (core: run build or rely on prepare). App migrations should be transpiled or run via ts-node/tsx strategy—(NOTE: current CLI reads only compiled JS from core; app migrations in TS require build or future ts loader support. For now prefer JS in app migrations or compile them.)
4. Run `db:migrate`.
5. Add tests / dump structure if needed.

## Example Migration Skeleton
```ts
import { Kysely, sql } from 'kysely';

export async function up(db: Kysely<any>): Promise<void> {
  await db.schema.createTable('ejemplo')
    .addColumn('id', 'serial', col => col.primaryKey())
    .addColumn('nombre', 'varchar(255)', col => col.notNull())
    .execute();
  await sql`INSERT INTO ejemplo (nombre) VALUES ('PRUEBA')`.execute(db);
}

export async function down(db: Kysely<any>): Promise<void> {
  await db.schema.dropTable('ejemplo').execute();
}
```

## Appendix: Quick Commands
```
# Create & migrate DB
pnpm exec msipn db:create
pnpm exec msipn db:migrate

# Dump full structure snapshot
pnpm exec msipn db:structure:dump

# Rollback last migration
pnpm exec msipn db:rollback

# Open psql console
pnpm exec msipn db:console
```

---
This English continuation document will be updated as we expand migrations, introduce code generation, and layer API/UI functionality.

## External App Wrapper Usage (`packages/app-msipn/bin/msipn`)
When simulating a real external consumer application, always run database commands through the wrapper script inside `packages/app-msipn` instead of relying on a globally resolved CLI. This ensures:
1. The application `.env` is loaded (PostgreSQL credentials).
2. Node module resolution matches the external app's dependency tree.
3. Future per-app overrides (e.g., custom migration sources) are honored.

Examples (from repository root):
```
cd packages/app-msipn
./bin/msipn db:migrate
./bin/msipn db:rollback
./bin/msipn db:structure:dump
```

If you mistakenly run `pnpm exec msipn db:migrate` from the monorepo root, you may:
- Miss the intended environment variables.
- Execute with a different working directory causing migration source discovery differences.
- Encounter command-not-found (depending on workspace filter resolution circumstances).

Guideline: treat `./bin/msipn` as the authoritative entrypoint for engine operations in an external app context.

## Current Iteration Snapshot (2025-10-05)
This snapshot is meant to let a future assistant (or a new chat) resume without re-reading full history.

### Architecture State
- Monorepo packages: core engine (`msipn-core`), domain packages (persona, usuario, etnia, tdocumento), CLI (`msipn-cli`), DB helper (`msipn-db`), and a consumer app (`app-msipn`).
- Multi-source migrations working (core compiled JS + app runtime JS migrations).
- CLI dynamically imports `kysely` / `pg`; no hard dependency compiled into CLI bundle.
- Role constants and entity metadata registry operational (still lightweight, validation minimal).

### Database / Migrations
- Core migrations present: `202510051200__estructura_inicial`, `202510051230__create_example_table`.
- Tracking tables managed automatically by Kysely (manual creation removed).
- Rollback reverts only the last applied migration (penultimate target strategy).
- App dynamic migration test proves injection path for `<app>/db/migrations`.

### Testing (Vitest)
Active tests (green):
1. `migrations_core.test.ts` – apply, rollback, re-apply core migrations (cleans stray app dynamic migrations first).
2. `migrations_app_injection.test.ts` – generates and applies a dynamic JS migration (`example_inapp`), then rollbacks.
Skipped legacy placeholder: `migration_cycle.test.mjs` (kept only for historical reference, safe to delete later).

Environment handling: manual `.env` parser (`tests/setup-env.ts`) avoids prior ESM `dotenv` resolution issue.

### Tooling / Scripts
- App script `test` runs Vitest in non-watch mode.
- CLI commands: create, drop, migrate, rollback, structure dump/load, console.
- Post-migrate hook attempts `kysely-codegen` if binary exists (currently types not yet committed).

### Known Open / Optional Items
- (Optional) Isolate databases per test (pending checklist item) to allow future parallelization.
- Add test for duplicate migration name collision (warning path).
- Replace shell `psql` in tests with direct Kysely queries for performance and portability.
- Implement and test codegen artifact freshness (compare migration timestamps vs `db.d.ts`).
- Discover additional engine packages dynamically (pattern `@pasosdejesus/msipn-*`) and include their migrations.

### Recently Resolved Issues
- Removed manual creation of Kysely tracking tables (fixed `22P02` errors).
- Hardened `psql` invocation (escaped args; host/user flags conditional).
- Converted dynamic migration to `.js` for immediate execution without build.
- Neutralized legacy migration script to avoid duplicate side effects.
- Stabilized rollback test by removing dynamic app migrations before core validation.

### Conventions / Guidance
- Prefer English for code/comments going forward; keep Spanish for legacy table/column names and domain semantics.
- Name migrations with timestamp prefix `YYYYMMDDHHMM` for deterministic ordering and uniqueness.
- Application-level runtime migrations (in tests or quick experiments) should be written as `.js` until a TS loader is introduced.

### Quick Resume Checklist for Next Iteration
1. (If needed) Run: `cd packages/app-msipn && pnpm test` – should pass 2 suites, 1 skipped.
2. Implement next migration or feature (e.g., add new domain table) via new core migration.
3. Add corresponding test (core or app) to validate migration side effects.
4. (Optional) Introduce duplicate-name test and handle warning assertion.
5. Decide whether to remove the skipped legacy file permanently.

End of snapshot.
