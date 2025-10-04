# Handoff para Continuación por Otro Asistente IA

Este documento resume el estado ACTUAL del esfuerzo de migración/creación de un "engine" Next.js/TypeScript inspirado en el motor Rails `msip`, bajo el nombre `msipn`.

## Objetivo General
Construir un ecosistema modular reutilizable (similar a Rails Engine) que permita migrar progresivamente aplicaciones que hoy usan `msip` (Rails) hacia una base en Next.js/TypeScript conservando el esquema de la base de datos (PostgreSQL).

## Estructura Actual de Paquetes (`packages/msipn`)

- `core`: Tipos de metadata, roles, registro global de entidades, factory para tablas básicas.
- `domain-tdocumento`: Entidad tabla básica `tdocumento` (usa factory).
- `domain-etnia`: Entidad tabla básica `etnia` (usa factory).
- `domain-persona`: Entidad compleja `persona` con relaciones a `tdocumento` y `etnia`.
- `domain-usuario`: Entidad `usuario` con rol numérico y relación a `persona`.
- `db`: Configuración Kysely (ahora incluye `getDb()` singleton y preparación para codegen de tipos – aún `DB` es `any`).
- `cli`: Comandos `msipn` para operaciones de base de datos (create/drop/migrate/rollback/seed/schema dump/load).
- `dummy`: Pequeña app de consola para probar registro y permisos.

## Namespace NPM
Todos los paquetes usan el scope: `@pasosdejesus/msipn-*`.
Se usan dependencias internas con `"workspace:*"` para evitar publicación.

## Roles y Permisos
Roles numéricos (manteniendo compatibilidad):
- ADMIN = 1
- DIRECTOR = 3 (equivalente a ADMIN para permisos)
- OPERADOR = 5

Helpers en `core/src/roles.ts`:
- `esAdminLike(user)` devuelve true para rol 1 o 3.
- `tieneRol(user, rol)` verificación directa.

## Metadata y Tipos Clave (`core`)
- `EntityDefinition`: describe entidad (campos, filtros, validaciones, permisos, presentación).
- `FieldDefinition` (con variantes: string/text/integer/enum/timestamp/password y FK).
- `FilterDefinition` discriminada: operadores estándar (`eq|ilike|in|range|enum`) o `custom` con `customBuilderKey`.
- `PermissionSet`: funciones `read/create/update/delete` + (futuro) visibilidad de campos.
- `basicaMixin`: Campos y validaciones estándar de tablas básicas (`nombre`, `observaciones`, fechas, normalización a mayúsculas, validaciones temporales, placeholder de unicidad).
- `makeBasicaEntity(opts)`: Factory que instancia entidad básica, aplica mixin, permisos por defecto (solo admin-like puede crear/editar/borrar) y registra la entidad.
- `registry`: `registerEntity`, `getEntity`, `listEntities`, `ensureRegistered`.

## Entidades Implementadas
1. `tdocumento`
   - Extra campos: `sigla`, `formatoregex`, `ayuda`.
   - Validación ejemplo: `sigla_mayus` (en factory/extra validations si se desea extender).
2. `etnia`
   - Extra campo: `descripcion`.
3. `persona`
   - Campos: nombres, apellidos, numerodocumento, sexo (string), tdocumento_id (FK), etnia_id (FK), anio/mes/dia nac, timestamps.
   - Validaciones: actualmente básicas (placeholder — falta regex numdoc, constraint sexo dinámico, unicidad combinada).
   - Permisos: OPERADOR (5) puede crear/editar; admin-like puede todo.
4. `usuario`
   - Campos: nusuario, email, rol (integer), persona_id (FK), contraseña encriptada (placeholder), fechas habilitación, timestamps.
   - Permisos: sólo admin-like crear/editar/borrar usuarios.

## Dummy (`packages/msipn/dummy`)
Ejecución: `pnpm --filter @pasosdejesus/msipn-dummy run start`
Salida actual (ejemplo):
```
Entidades registradas:
- tdocumento ...
- etnia ...
- persona ...
- usuario ...
OPERADOR puede crear persona? true
ADMIN puede borrar persona? true
Dummy listo
```

Funciona compilando primero los paquetes dominio y luego ejecutando con `tsx`.

## Estado del `db` (Kysely)
- Paquete `db` expone `getDb()` y `closeDb()` usando `Kysely` + `pg`.
- Tipado `DB` placeholder (`any`) hasta ejecutar `pnpm --filter @pasosdejesus/msipn-db run codegen` (cuando haya migraciones y base creada).
- Archivo de config: `.config/kysely.config.ts` (usado por `kysely-ctl` para migraciones y codegen).
- Pendiente: generar `src/db.d.ts` y reemplazar export `DB`.

## Problemas Resueltos Durante Iteración
- Renombrado completo `nextjs` → `msipn` (paths en `tsconfig.base.json`, `pnpm-workspace.yaml`, imports, names en package.json).
- Error de tipos en filtros (operator: string) solucionado con discriminated union.
- `pnpm` intentando resolver paquetes internos desde registry → resuelto usando `workspace:*`.
- Estructura de build y ausencia de `dist/index.js` → se ajustó main para apuntar a rutas reales generadas en `dist/<paquete>/src/index.js`.
- Ejecución TS ESM problemática con `ts-node` → migración a `tsx` para simplificar.
- Se añadió CLI `msipn` con comandos de gestión de BD inspirados en Rails.
- `db:structure:*` fue reemplazado por `db:schema:*` (orientado a metadata JSON en lugar de volcado SQL plano).

## Aspectos Pendientes / Roadmap Próximo
1. DB / Kysely
   - Ejecutar realmente `codegen` para generar `src/db.d.ts` y sustituir `any`.
   - Integrar `db:schema:dump` con generación adicional opcional de un `generated-schema.ts` (metadatos msipn enriquecidos).
   - Implementar `db:schema:load` que aplique diffs (crear tablas/alterar columnas).
2. API Layer
   - Paquete `api` con funciones generadoras CRUD (`list`, `show`, `create`, `update`, `delete`) tomando `EntityDefinition` y `db`.
   - Manejo de filtros (traducir `FilterDefinition` a condiciones Kysely). Soporte para operadores `ilike`, `eq`, `custom` (hooks para builder).
3. Validaciones Asíncronas
   - Unicidad `nombre` en básicas; unicidad `numerodocumento` + `tdocumento_id` en persona.
   - Posible interfaz: `asyncValidations?: Array<(record, ctx, db) => Promise<true|string>>`.
4. Constraint / Normalizaciones Extras
   - Campo `sexo`: derivar lista dinámica desde convención (`F`,`M`,`S`?) o tabla configuración.
5. Auth / Contexto Request
   - Definir `RequestContext` mínimo: `{ user?: { id: number; rol: number } }`.
   - Implementar verificación de permisos en CRUD automático antes de operar.
6. UI (futuro inmediato)
   - Paquete `ui` con primer `renderTable(entityName, rows)` y `renderForm(entityName, data)` (aunque sea consola/HTML minimal) para probar metadata.
7. CLI / Codegen Metadata
   - Extender `db:schema:dump` para producir además `db/generated-schema.ts` con tipos y posible traducción a `EntityDefinition` parcial.
8. Tests
   - Snapshot de metadata (`JSON.stringify(listEntities())`) comparado contra baseline.
   - Tests de permisos (roles distintos). 
   - Tests de validaciones sync.
9. Capa de Caché / ETag
   - Para tablas básicas: hash de `updated_at`/`fechadeshabilitacion`.
10. Refinamiento de Packaging
    - Revisar si conviene volver a `main: dist/index.js` generando un barrel manual (evitar paths profundos) — simplificaría consumo externo.

## Recomendaciones Técnicas para Próxima Persona/IA
- Empezar por el paquete `db`: sin tipos generados no se puede implementar CRUD real.
- Decidir si se añadirán migraciones dentro de `db/migrations` y un script `migrate` (kysely migrator o `umzug`).
- Al generar CRUD, asegurar conversión de `FieldDefinition` a tipos runtime (p.ej. casting de enteros y timestamps).
- Encapsular autorización: función `authorize(entity, action, ctx)` antes de operar.
- Preparar un adaptador de filtros: traducir `ilike` a `where(field, 'ilike', '%' + value + '%')` (puede requerir extensión/SQL raw).

## Comandos Útiles
```
# Listar entidades (dummy)
pnpm --filter @pasosdejesus/msipn-dummy run start

# Re-construir todo
pnpm build

# CLI msipn (ver ayuda)
pnpm --filter @pasosdejesus/msipn-cli exec msipn --help

# Crear base, migrar y generar metadata de esquema
pnpm --filter @pasosdejesus/msipn-cli exec msipn db:create
pnpm --filter @pasosdejesus/msipn-cli exec msipn db:migrate
pnpm --filter @pasosdejesus/msipn-cli exec msipn db:schema:dump

# Semillas
pnpm --filter @pasosdejesus/msipn-cli exec msipn db:seed

# Revertir última migración
pnpm --filter @pasosdejesus/msipn-cli exec msipn db:rollback

# (Próximo) Generar tipos Kysely
pnpm --filter @pasosdejesus/msipn-db run codegen
```

## Posibles Riesgos
- Cambios futuros de estructura `dist/` pueden invalidar `main` de paquetes.
- Faltan pruebas — riesgo de regresiones silenciosas.
- Falta normalización de dependencias exactas para DB (no añadidas aún).
- ESM vs CJS: actualmente ESM; mantener coherencia al agregar herramientas CLI (node >=18 soporta bien ESM, pero usar `tsx` ayuda en dev).

## Decisiones de Diseño Clave
- Metadata primero: generación futura de UI/API se apoya en definiciones estáticas.
- Roles numéricos conservados (compatibilidad migración gradual desde Rails/msip).
- Factory `makeBasicaEntity` para replicar comportamiento DRY de `Msip::Basica`.
- Separación conceptual de capas prevista: core (metadata) / db / api / ui / auth / cli.

## Próxima Tarea Recomendada (Sugerencia)
Implementar paquete `api` mínimo con:
- `createCrudHandlers(entityName: string)` que devuelva `{ list(ctx, params), show(ctx, id), create(ctx, data), update(ctx, id, data), delete(ctx, id) }`.
- Internamente, resolver entidad vía `getEntity`, validar permisos, aplicar validaciones sync (y preparar hook para async), mapear filtros básicos.
- Usar un mock temporal `InMemoryAdapter` si aún no está listo Kysely — así se puede probar flujo end-to-end antes de DB real.

---
Este documento debe mantenerse actualizado si se cambia estructura, nombres o se agregan capas fundamentales.
