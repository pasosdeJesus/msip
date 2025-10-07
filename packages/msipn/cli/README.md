# @pasosdejesus/msipn

CLI para utilidades de msipn (inspirado en `bin/rails`). Provee comandos para manejo de base de datos y migraciones.

## Comandos disponibles

Ejecute `msipn --help` para ver la lista actual (se localiza según `LANG`). Ejemplos:

```
# Inglés (por omisión si LANG no es español)
msipn --help

# Español
LANG=es msipn --help
```

## Internacionalización (i18n) del CLI

Las descripciones de los comandos y textos del CLI se traducen usando `i18next` con archivos JSON en `locales/<lang>/cli.json`.

### Estructura de archivos de idioma

```
cli/
  locales/
    en/cli.json
    es/cli.json
```

Cada archivo contiene un árbol con secciones como `cmd.program_description` y `cmd.db.<accion>`.

Ejemplo (extracto en inglés):
```json
{
  "cmd": {
    "program_description": "msipn CLI (inspired by bin/rails)",
    "db": {
      "create": "Create database",
      "drop": "Drop database"
    }
  }
}
```

### Pasos para agregar una nueva traducción de comando

1. Identifique un namespace lógico (por ejemplo existente `db`). Si es un grupo nuevo cree un objeto nuevo dentro de `cmd` (p.ej. `jobs`).
2. Agregue la clave en todos los archivos de idiomas existentes (`en/cli.json`, `es/cli.json`, etc.). Mantenga el mismo árbol de claves.
3. En el código fuente (`src/index.ts`), registre el comando usando el traductor:
   ```ts
   program.command('db:nuevo').description(t('cmd.db.nuevo')).action(async () => { /* ... */ });
   ```
4. Si la lógica del comando requiere nuevos mensajes (progreso, errores) añádalos en una sección apropiada (`structure`, `migrate`, o cree una nueva p.ej. `jobs`). Use interpolaciones `{{variable}}` cuando sea necesario.
5. Reconstruya el paquete si se distribuye compilado (`pnpm build` o equivalente) y pruebe:
   ```bash
   LANG=en msipn --help | grep db:nuevo
   LANG=es msipn --help | grep db:nuevo
   ```
6. (Opcional) Añada/actualice pruebas en `app-msipn/tests/ordered/01_i18n_env.test.ts` añadiendo aserciones similares a las existentes para validar la nueva línea en ambos idiomas.

### Recomendaciones
- Mantenga las descripciones concisas y en infinitivo/imperativo.
- Evite duplicar información: el nombre del comando debe ser auto-explicativo; la descripción complementa.
- Cuando cambie una clave, actualice todas las traducciones simultáneamente para no romper tests.

### Añadir un nuevo idioma
1. Cree carpeta `locales/<nuevo_idioma>/`.
2. Copie `cli.json` desde `en` como plantilla.
3. Traduza todas las claves.
4. No elimine claves: si una clave falta se usará fallback y puede causar mezcla de idiomas.

## Desarrollo

El binario ejecutable (`bin/msipn.js`) carga variables `.env` del directorio de trabajo y luego importa `dist/index.js` (generado a partir de `src/index.ts`). Asegúrese de reconstruir después de cambios en `src/` si publica o usa sin soporte ESM directo.

## Pruebas

El paquete de aplicación (`app-msipn`) incluye pruebas ordenadas que validan i18n del CLI. Ejecútelas desde la raíz del monorepo:

```
pnpm --filter @pasosdejesus/app-msipn test
```

## Licencia

Ver archivo LICENSE.md en la raíz del repositorio.
