# Información dedicada a contribuidores #

## Addendum: Internationalization (i18n) for msipn engine components

Although the historical documentation and many code comments are in Spanish, new work in the **msipn** TypeScript/Next.js engine layer must follow these i18n conventions to promote clarity and reuse.

### Principles
1. Preserve legacy PostgreSQL table and column names (Spanish) — they are part of the stable public schema ("remove not the ancient landmark" – Proverbs 22:28).
2. Prefer English for new code comments, identifiers, and user-facing messages; supply Spanish in locale files when relevant.
3. Validation logic should return stable translation keys (e.g. `validation.usuario.email_invalid`) rather than hard‑coded human text.
4. CLI and domain/entity messages must be centralized under locale JSON resources, not inline strings ("Let all things be done decently and in order." – 1 Corinthians 14:40).
5. Keep messages short, actionable, and neutral; avoid embedding variable data directly in text—use interpolation variables.

### Directory Layout (current)
Core domain/entity messages:
```
packages/msipn/core/locales/<lang>/domain.json
```
CLI operational messages:
```
packages/msipn/cli/locales/<lang>/cli.json
```

### Key Naming Conventions
| Area | Pattern | Example |
|------|---------|---------|
| Entity labels | `entity.<entity>.singular` / `entity.<entity>.plural` | `entity.tdocumento.singular` |
| Validation messages | `validation.<entity>.<rule>` | `validation.persona.month_out_of_range` |
| CLI structure tasks | `structure.<action>` | `structure.dump_start` |
| CLI migrations | `migrate.<token>` | `migrate.applied` |
| CLI rollback | `rollback.<token>` | `rollback.reverting` |
| CLI seed | `seed.<token>` | `seed.applied` |
| CLI console | `console.<token>` | `console.pgdatabase_missing` |
| Kysely load errors | `kysely.<token>` | `kysely.load_error` |

Rules:
* Use lowercase, snake_case for rule suffixes (e.g. `email_invalid`).
* Prefer nouns/adjectives for labels; verbs for process events.
* Avoid tense in keys—tense belongs to localized value.

### Adding a New Message
1. Decide namespace (`domain.json` vs `cli.json`).
2. Add English entry first; mirror in Spanish if applicable.
3. If variable data is needed, use i18next interpolation: `"applied": "Applied migration {{name}}"`.
4. Reference key in code; do not inline literal text.

### Validation Flow
1. Validation function returns either `true` or a key string (`validation.*`).
2. Presentation / API layer resolves the key with `t(key)`; if key not found, log a warning and show a generic fallback.

### Environment Locale Detection (CLI)
The CLI chooses locale based on `LANG` / `LC_ALL` / `LC_MESSAGES` (first matching `en` or `es`, otherwise falls back to `en`). Override by exporting `LANG=en_US.UTF-8` (etc.).

### Testing
* Add integration tests (Vitest) in consumer app verifying at least one English and one Spanish key.
* When adding a new namespace or large batch of keys, include a test ensuring no orphaned keys (future enhancement: lint script).

### Do / Don’t Summary
**Do** return `validation.usuario.email_invalid` — **Don’t** return `"Invalid email"` directly.
**Do** add both `en` and `es` entries — **Don’t** leave keys untranslated in the default fallback if Spanish is still in active use.
**Do** group related CLI messages — **Don’t** create one-off JSON files per message.

### Future Enhancements (Planned)
* Add script to detect unused / missing translation keys.
* Support per-request locale injection for API responses.
* Add pluralization utilities if needed (currently labels handle plural explicitly).

“Let your speech be alway with grace, seasoned with salt…” (Colossians 4:6) — concise, clear, and edifying messages help every contributor and user.


## 1. Términos de reproducción

Al hacer una contribución estás aceptando los términos de reproducción
que estamos usando para este motor, que encuentras en:
[LICENCIA.md](LICENCIA.md)

## 2. Tareas de integración continua

El archivo [README.md](README.md) incluye varias banderas que queremos dejar en
buen estado:
  1. Que pase pruebas en plataforma de integración continua. Agradecemos
     servicio a _gitlab_.
  2. Buen porcentaje de mantenibilidad y cobertura. Agradecemos servicio a
     _Codeclimate_.
  3. No deben haber fallas de seguridad y los falsos positivos deben marcarse
     como tales en _Hakiri_ (al cual agradecemos por el servicio de auditoría).


## 3. Desarrollo y aplicación de prueba

Puedes probar el motor msip y los cambios que hagas en la aplicación de prueba
disponible en el directorio `test/dummy`

Para hacer operar la aplicación sigue las instrucciones disponibles en 
[doc/aplicacion-de-prueba.md](doc/aplicacion-de-prueba.md)



## 4. Uso recomendado de git

### 4.1 Configuración inicial

Consideramos que tu contribución a `msip` (y a otros proyectos de código
abiertas) será más ordenada si sigues los lineamientos de uso de FreeCodeCamp
(ver <https://github.com/freeCodeCamp/freeCodeCamp/blob/main/docs/how-to-setup-freecodecamp-locally.md>),
que procuramos resumir aquí:

1. Desde tu cuenta en gitlab bifurca (del inglés fork) el 
   repositorio (<https://gitlab.com/pasosdeJesus/msip>) a tu cuenta personal.
2. En el computador de desarrollo clona tu bifurcación:
  ```
  git clone git@gitlab.com/miusuario/msip.git
  ```
3. En la nueva copia en el computador de desarrollo asegúrate de tener
   2 repositorios remotos configurados: (1) `origin` que apunte a tu 
   bifurcación y (2) por ejemplo `upstream` que apunte a las fuentes originales.
   Puedes ver tus repositorios remotos con `git remote -v` y agrega las
   fuentes de Pasos de Jesús de msip como `upstream` con:
  ```
  cd msip
  git remote add upstream https://gitlab.com/pasosdeJesus/msip.git
  ```

Procura mantener la rama `main` de tu bifurcación "sincronizada" con la
rama `main` del repositorio `upstream` (por lo mismo no debes hacer cambios
a la rama `main` de tu bifurcación).  Lo puedes hacer ejecutando con
regularidad:
  ```
  git checkout main
  git pull --rebase upstream main
  git push -f origin main
  ```
Y si en el proceso se presentan conflictos resolviéndolos como se explicará
más adelante.

### 4.2 Iniciar una contribución

Cuando desees hacer una contribución, comienza por sincronizar tu rama
`main` y desde esta crear una nueva rama donde propondrás el cambio.
Ponle a la nueva rama un título que te ayude a recordar el cambio (si deseas
hacer cambios diferentes es mejor que hagas ramas diferentes a partir
de la rama `main` sincronizada), por ejemplo:
  ```
  git checkout main
  git pull --rebase upstream main
  git push -f origin main
  git checkout -b mejora-documentacion
  ```
En la nueva rama agrega, edita y/o elimina archivos. Puedes averiguar
modificaciones a archivos con:
  ```
  git status -s
  ```
agrega un archivo con:
  ```
  git add _archivo_
  ```
Cuando completes los cambios realiza un `commit` y escribe un comentario
sobre la contribución, por ejemplo:
  ```
  git commit -m "Mejorando documentación para quienes contribuyen" -a
  ```
Puedes continuar trabajando y hacer otras contribuciones en la misma rama,
pero nos parece más ordenado cuando tu solicitud de cambio (pull request)
tiene una sola contribución (commit) y no muchas que sobreescriben otras.
Si tienes varias contribuciones para un mismo pull-request más bien
fusiónalas (del inglés squash) en una sola.
Por ejemplo puedes fusionar los 2 últimos commits con:
  ```
  git rebase -i HEAD~2
  ```
Esto abrirá un archivo con los mensajes de las 2 últimas contribuciones
y frente a cada uno la palabra `pick` que podrías cambiar por `squash`
en la segunda contribución para fusionarla con la primera.  Después de guardar
y salir volverás a un editor para modificar el mensaje que tendrá la
contribución fusionada

Tras esto si ves la historia de contribuciones notarás la fusión:
  ```
  git log
  ```
Una vez tengas bien tu contribución en orden, empuja el cambio a la rama
que creaste en tu bifurcación:
  ```
  git push -f origin mejora-documentacion
  ```
Y desde la interfaz de gitlab examinando tu repositorio bifurcado o el
original de Pasos de Jesús verás un botón para crear la solicitud de
cambio (pull request).  Úsalo, revisa lo que enviarás, pon un comentario
que justifique el cambio y envíalo.

Cuando hagas un pull request se iniciarán sobre el mismo las tareas de
integración continua que hemos configurado en gitlab y que en general
tu cambio debe pasar. Si no habías sincronizado la rama `main` de tu 
repositorio `origin` con la rama `main` del repositorio de Pasos de Jesús verás
en la interfaz de gitlab un mensaje indicando que hay conflictos que deben
resolverse antes.

Una vez tu solicitud de cambio no tenga conflictos los desarrolladores de 
msip la revisarán y si se requiere escribirán comentarios con sugerencias para 
que lo mejores, que debes hacer o justificar por que no conviene antes de 
que tu contribución sea aceptada.
Es decir habrá un diálogo en la parte de comentarios de tu solicitud de
cambio que debe continuar.


### 4.3 Mejorar una contribución

Con la retroalimentación de las tareas de integración continúa y de
desarrolladores debes realizar los cambios en la misma rama donde
hiciste la propuesta inicial, pero antes debes sincronizarla con la
rama `main` del repositorio de Pasos de Jesús por si otros desarrolladores
han hecho cambios recientes. Para eso primero sincroniza tu rama main:
```
git checkout main
git pull --rebase upstream main
git push -f origin main
```
Y de inmediato toma en tu rama donde hiciste la propuesta, los cambios que
pudiera haber en la rama `main` ya sincronizada:
```
git checkout mejora-documentacion
git pull --rebase origin main
```
Esta última operación podría revelar colisiones entre cambios ya aceptados
en el repositorio principal y los que tú habías propuesto (por eso es bueno
tratar de hacer rápido el diálogo con desarrolladores y las propuestas de
cambio).  En caso de colisiones debes arreglarlas (en algunos casos editando
archivos que tienen marcados los cambios con `<<<<` y `>>>>`, en otros
añadiendo o eliminando archivos).
Después aplica las sugerencias y/o fusiona contribuciones y/o arregla tu
código para que pase tareas de integración continua.
```
$EDITOR README.md
....
git commit -m "Aplicando sugerencias de revisor" -a
git rebase -i HEAD~2
git push -f origin mejora-documentacion
```
Después de empujar tus cambios (push) en la misma rama, gitlab notará
el cambio y actualizará la solicitud de cambio ya hecha, volviendo a
lanzar las tareas de integración continua y los desarrolladores
volverán a auditar tu contribución y continuarán el diálogo en la sección
de comentarios.

Este proceso debe iterarse hasta que tu cambio sea aceptado (o rechazado),
por lo que debes visitar con frecuencia tu solicitud de cambio y ver
nuevos comentarios que puedan haber (los comentarios más recientes
quedan al final de la pestaña de comentarios).

## 5. Pruebas Unitarias y de Integración

Suele bastar desde el directorio raíz de las fuentes
  o desde `test/dummy` si es un motor:
```sh
SEMILLA_PEQ=1 CONFIG_HOSTS=www.example.com RUTA_RELATIVA=/ bin/regresion.sh
```
o puedes ejecutar pruebas específicas con:
bundle exec rails test test/models/
CONFIG_HOSTS=www.example.com RUTA_RELATIVA bundle exec rails test test/controllers/
bundle exec rails test test/helpers/

Y examinar el reporte de cobertura en `cobertura-unitarias/index.html`

Hay también pruebas al sistema, mira detalles en [pruebas al sistema con Puppeteer](doc/pruebas-al-sistema-con-puppeteer.md) e [integración GitHub Actions OpenBSD](doc/github-actions-openbsd-puppeteer.md).

### 5.1 Pruebas del motor TypeScript (msipn) con orden fijo

El motor y su CLI tienen una batería de pruebas en TypeScript (Vitest) localizada en la aplicación de ejemplo `packages/app-msipn`. Para ejecutarlas en el orden previsto (algunas dependen de efectos previos como creación de roles o bases de datos) usa el script:

```sh
cd packages/app-msipn
./bin/ordered-tests.sh
```

El script:
* Ejecuta cada archivo de `tests/ordered/` en secuencia estricta.
* Se detiene ante el primer fallo (retorno distinto de 0).
* Reduce la posibilidad de interferencias entre pruebas que modifican el mismo estado (p.ej. roles PostgreSQL, migraciones, archivos generados).

Si necesitas correr una sola prueba individual (por depuración):
```sh
cd packages/app-msipn
npx vitest run tests/ordered/03_db_create_drop_create.test.ts
```

Limpieza de artefactos temporales:
* La prueba `05_migrations_app_injection.test.ts` elimina la migración temporal `__create_example_inapp` que crea durante su ejecución.
* Si interrumpes manualmente el script, verifica y elimina residuos en `packages/app-msipn/db/migrations/` antes de reintentar.

Requisitos previos típicos (variables de entorno): `PGUSER`, `PGPASSWORD`, `PGDATABASE`, `PGHOST` (opcional), asegurando que el rol tenga permisos adecuados para crear y borrar bases de datos de prueba.

Requisito de servicio: asegúrate de que el servidor PostgreSQL esté arrancado antes de ejecutar `./bin/ordered-tests.sh` (p.ej. en Debian/Ubuntu `sudo service postgresql start`). Si el daemon no está disponible, las pruebas a partir de `02_db_super_createuser` fallarán con "connection refused".

Para forzar mensajes en español o inglés puedes usar `LANG=es` o `LANG=en` al invocar el script.

## 6. Otros aspectos a tener en cuenta

* Durante el desarrollo de tu contribución actualiza constantemente
  las dependencias para usar siempre las versiones más recientes de librerías
  y motores: `bundle update; bundle install`

* La plataforma principal de desarrollo y de producción es adJ
  (Distribución de OpenBSD) ver descripción en:
	<https://aprendiendo.pasosdeJesus.org>
  Por eso después de hacer cambios sugerimos que en esa plataforma pruebes
  las novedades que introduces y que ejecutes las pruebas de regresión para
  asegurar que pasan.
  
* Sigue las convenciones acordes al lenguaje de lo que estás aportando
  descritas en [Convenciones](https://gitlab.com/pasosdeJesus/msip/blob/main/doc/convenciones.md)
