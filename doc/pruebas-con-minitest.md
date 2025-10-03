# Pruebas con minitest

Se han implementado algunas pruebas con minitest a modelos, controladores, 
vistas, rutas y de integración.

* Sigue los mismos pasos para la creación de una aplicación de pruebas 
con **msip**, hasta la creación de la base de datos.  
Ver <https://gitlab.com/pasosdeJesus/msip/-/blob/main/doc/aplicacion-de-prueba.md?ref_type=heads>
* Ejecuta las pruebas con la semilla de datos completas desde el directorio del motor con:
  ```sh
  bin/regresion.sh
  ```
  o si prefieres usar una semilla pequeña sin la información geográfica completa:
  ```sh
  bin/regresion.sh
  ```
* Si necesitas depurar pruebas,  en la prueba donde quieres iniciar la 
  depuración usa `debugger`.  
* Para ejecutar las pruebas de un solo modelo, por ejemplo las de 
  `test/models/usuario_test.rb` usa:
  ```
  bin/rails test test/models/usuario_test.rb
  ```
  o de un solo controlador:
  ```
  CONFIG_HOSTS=www.example.com RUTA_RELATIVA=/ bin/rails test test/controllers/usuario_controller_test.rb
  ```
* Y para ejecutar una sola de las pruebas de un archivo usa el nombre del 
  archivo y el nombre de la prueba, por ejemplo:
  ```
  bin/rails test test/models/usuario_test.rb valido
  ```
* Al hacer una nueva prueba recuerda mantener el estado de la base de datos.
  Al iniciar la prueba queda como tras ejecutar:
  `RAILS_ENV=test bin/rails db:drop db:setup db:migrate msip:indices`
  Y cuando la prueba concluya debe quedar igual. 
  Es decir elimina los objetos que crees en la base de datos.



## Patrón de respuestas JSON en controladores basados en ModelosController

Los controladores de tablas básicas y otros que incluyen el concern `Msip::Concerns::Controllers::ModelosController` (directa o indirectamente a través de `BasicasController`) exponen un patrón uniforme para peticiones con `Accept: application/json` o enviadas con `as: :json` desde pruebas. Este patrón busca:

1. Evitar dependencias en helpers de URL polimórficos no convencionales (eliminando `location:` en `render` JSON de create).
2. Entregar estados HTTP claros y consistentes para éxito y error.
3. Proveer un cuerpo JSON mínimo y fiable sin requerir plantillas adicionales salvo `show.json.jbuilder` cuando se desea controlar la forma exacta de la representación en `show`/`create`.

### Create (`POST`)

- Validaciones fallan: HTTP 422 con cuerpo JSON de errores (`@registro.errors`).
- Éxito: HTTP 201 con cuerpo JSON del registro serializado (`@registro.as_json`).
- No se incluye cabecera `Location` para evitar fallos en motores con nombres de recursos no convencionales.

### Update (`PATCH`/`PUT`)

- Éxito: HTTP 204 (`No Content`) sin cuerpo, por simplicidad y para reducir tráfico. (En algunos entornos podría observarse 200/302 si hay lógicas adicionales ajenas al concern; las pruebas admiten cualquiera de esos siempre que la actualización se refleje en el modelo.)
- Error de validación: HTTP 422 con cuerpo JSON de errores.

### Destroy (`DELETE`)

- Éxito: HTTP 204 (`No Content`).
- Si el registro tiene asociaciones `has_many` o `has_and_belongs_to_many` no vacías y no se permite eliminación, se responde en HTML con redirección y `flash[:error]`. Para exponer también esa lógica de bloqueo en JSON podría incorporarse en el futuro un `render json: { error: mens }, status: :unprocessable_entity` antes del `redirect_back`.

### Show / Index

- `index` JSON entrega lista serializada de registros. Si se pasa `presenta_nombre=1` (directo o dentro de filtro) sólo incluye pares `{ id, presenta_nombre }`.
- `show` puede renderizar una plantilla `show.json.jbuilder` opcional para controlar campos expuestos. Si no existe, el concern intenta serializar el objeto directamente.

### Errores de validación

En create y update los errores se devuelven siempre como JSON simple (estructura estándar de Rails ActiveModel::Errors serializada) con código 422 para facilitar consumo por clientes front-end o integraciones.

### Buenas prácticas al añadir nuevas pruebas JSON

- Usar `as: :json` en las llamadas `post`/`patch`/`delete` de Minitest.
- Verificar en creación `assert_difference` del modelo y `response.status == 201`.
- Para errores, `assert_no_difference` y `response.status == 422`.
- En update exitoso permitir `assert_includes [200, 204, 302], response.status` si aún hay controladores heredados con flujos HTML mezclados; a mediano plazo converger a 204.
- Limpiar datos de prueba (`destroy`) cuando se crean registros ad-hoc para no interferir con otras pruebas.

### Extensión a otros modelos

Para exponer JSON en un nuevo controlador básico:
1. Crear `app/views/msip/admin/<tabla>/show.json.jbuilder` con los campos requeridos (opcional pero recomendado).
2. Añadir pruebas de create/update JSON siguiendo los ejemplos en:
  - `test/controllers/msip/admin/tdocumentos_controller_test.rb`
  - `test/controllers/msip/admin/etnias_controller_test.rb`
  - `test/controllers/msip/admin/grupos_controller_test.rb`

### Futuras mejoras sugeridas

- Unificar siempre update exitoso a 204.
- Añadir respuesta JSON para bloqueos en destroy.
- Incorporar paginación y metadatos en index JSON si se requiere en clientes externos.