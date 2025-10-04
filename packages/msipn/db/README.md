# @pasosdejesus/msip-db

Configuración de Kysely para el ecosistema msip en Next.js.

## Scripts
- `pnpm --filter @pasosdejesus/msip-db migrate:make <nombre>` Crear nueva migración.
- `pnpm --filter @pasosdejesus/msip-db migrate:up` Aplicar migraciones.
- `pnpm --filter @pasosdejesus/msip-db migrate:down` Revertir última migración.
- `pnpm --filter @pasosdejesus/msip-db codegen` Generar tipos `src/db.d.ts` desde la BD.

## Pasos iniciales
1. Copiar `.env.template` a `.env` y ajustar credenciales.
2. Crear base de datos y usuario si no existen.
3. Ejecutar migraciones.
4. Generar tipos con codegen.

## Uso en código
```ts
import { Kysely } from 'kysely';
import cfg from './.config/kysely.config';
import { DB } from './src/db'; // tras codegen ajustar ruta

const db = new Kysely<DB>({ dialect: cfg.dialect });
```

## Notas
- Ajustar pooling y SSL según entorno.
- Para desarrollo en OpenBSD usar socket local si aplica.