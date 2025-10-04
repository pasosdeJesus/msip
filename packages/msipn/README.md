# Engine Next.js msip (MVP)

Este directorio contendrá un ecosistema modular inspirado en msip (Rails Engine) para ser usado en proyectos Next.js.

## Objetivo
Proveer paquetes reutilizables que permitan:
- Definir entidades (metadata) con campos, validaciones, relaciones, filtros y permisos.
- Generar CRUD/API handlers y vistas (listas y formularios) automáticos.
- Integrar autenticación y autorización basada en roles numéricos existentes (ADMIN=1, DIRECTOR=3, OPERADOR=5).
- Migrar progresivamente proyectos basados en msip sin reescribir toda la lógica a la vez.

## Paquetes Planeados

```
packages/msipn/
  core/                # Tipos metadata, registro de entidades, mixins basica, permisos base
  db/                  # Configuración Kysely, conexión, migraciones, seeds
  domain-persona/      # Entidad persona y lógica específica
  domain-etnia/        # Entidad etnia (tabla básica)
  domain-tdocumento/   # Entidad tdocumento (tabla básica)
  domain-usuario/      # Entidad usuario + mapeo roles numéricos
  ui/                  # Componentes generativos (AutoForm, DataTable, FieldRenderer)
  api/                 # Fabricas de handlers CRUD
  auth/                # Adaptadores de sesión y roles
  cli/                 # Herramientas de introspección y codegen
```

## MVP Inicial
Incluye entidades: usuario, persona, tdocumento, etnia.

### Reglas
- DIRECTOR comparte permisos de ADMIN.
- OPERADOR puede crear/editar persona, no gestionar tablas básicas ni usuarios.

### Pendiente
- Validación regex numerodocumento (pospuesta)
- Integrar constraint dinámico para sexo en persona (convención FMS/MHS)
- Codegen desde PostgreSQL (CLI)

## Roadmap Resumido
1. Definir tipos `EntityDefinition` y `basicaMixin` (listo en diseño).
2. Implementar registro global y carga de entidades.
3. CRUD genérico (list/show/create/update) para persona y tablas básicas.
4. UI auto-generada (tabla + formulario) con validación cliente/servidor.
5. Filtros básicos eq/ilike.
6. Autenticación placeholder (usuario fijo) → luego NextAuth/custom.
7. CLI: introspección de una tabla → genera metadata stub.
8. Pruebas: snapshot metadata + contract tests (futuro).

## Inspiración msip
- `Msip::Basica` → `basicaMixin`
- `Msip::Modelo` → validaciones + presentación centralizadas.
- Ability/CanCan → Policy/permissions en metadata.

---
Este README evolucionará conforme se agreguen implementaciones.
