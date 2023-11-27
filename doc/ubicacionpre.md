
# Ubicaciones predefinidas - Ubicacionpre

Su objetivo es facilitar reusar ubicaciones previamente empleadas en el 
sistema de información.

Por ejemplo Tierra Amarilla es un sector rural en el municipio de San José de
Apartado en Antioquia, Colombia, donde los paramilitares han montado
retenes en muchas oportunidades para violentar a la población.  
En un sistema sin  ubicaciones predefinidas cada caso tendría
duplicada esa ubicación, con ubicaciones predefinidas sería posible
reusar la misma ubicación de casos anteriores.

Para implementar esta funcionalidad se emplea la tabla `msip_ubicacionpre`
cuyos campos son:

| nombre | tipo | cotejacion | puede ser null | predeterminado |
|---|---|---|---|---|
| id               | bigint                      |             | not null | nextval('msip_ubicacionpre_id_seq'::regclass)|
| nombre           | character varying(2000)     | es_co_utf_8 | not null | |
| nombre_sin_pais  | character varying(500)      |             |          | |
| pais_id          | integer                     |             |          | |
| departamento_id  | integer                     |             |          | |
| municipio_id     | integer                     |             |          | |
| centropoblado_id | integer                     |             |          | |
| vereda_id        | integer                     |             |          | |
| lugar            | character varying(500)      |             |          | |
| sitio            | character varying(500)      |             |          | |
| tsitio_id        | integer                     |             |          | |
| latitud          | double precision            |             |          | |
| longitud         | double precision            |             |          | |
| created_at       | timestamp without time zone |             | not null | |
| updated_at       | timestamp without time zone |             | not null | |


Esta tabla referencia dos conjuntos de ubicaciones
1. La división política equivalente a la de las tablas básicas 
   msip_pais, msip_departamento, msip_municipio, msip_centropoblado y
   msip_vereda (que ha buscado estandarizarse y mantenerse actualizada en 
   msip aunque podría cambiarse en cada sistema de información que use msip).
2. Los lugares y sitios específicos de un sistema de información que usa msip.


Las primeras tienen las siguientes características:
* Emplean `id` inferior a 1'000.000
* Tienen en `NULL` los campos `lugar` y `sitio`
* Los países tienen en `NULL` los campos `departamento_id`,  `municipio_id`,
  `centropoblado_id`, `vereda_id`, `tsitio_id`. La latitud y la longitud 
  corresponden a un punto hacia el centro del país. El nombre corresponde al 
  del país e.g. Venezuela.
* Los departamentos tienen en `NULL` los campos `municipio_id`,
  `centropoblado_id`, `vereda_id`, `tsitio_id`. La latitud y la longitud 
  pueden corresponder a un punto hacia el centro del departamento o `NULL`, 
  `NULL`.
  El nombre consta del departamento y el país separados por barra de
  división, e.g. Arauca / Colombia
* Los municipios tienen en `NULL` los campos `centropoblado_id`, 
  `vereda_id`, `tsitio_id`. La latitud y la longitud 
  pueden corresponder a un punto hacia el centro del municipio o 
  `NULL`, `NULL`.
  El nombre consta del municipio, el departamento y el país separados 
  por barras de división, e.g. Angelópolis / Antioquia / Colombia
* Los centros poblados tienen en `NULL` el campo `vereda_id`. 
  El campo `tsitio_id` es 2 (i.e. URBANO). La latitud y la longitud 
  pueden corresponder a un punto hacia el centro del centro poblado o 
  `NULL`, `NULL`.
  El nombre consta del centro poblado, el municipio, el departamento 
  y el país separados por barras de división, e.g. 
  Paloma / Tucupita / Delta Amacuro / Venezuela
* Las veredas tienen en `NULL` el campo `centropoblado_id`. 
  El campo `tsitio_id` es 3 (i.e. RURAL). La latitud y la longitud 
  pueden corresponder a un punto hacia el centro de la vereda o `NULL`, 
  `NULL`.
  El nombre consta de la palabra `Vereda ` seguida del nombre
  de la vereda, el municipio, el departamento y el país separados por 
  barras de división, e.g. Vereda Los Alpes / Saravena / Arauca / Colombia


Por su parte las segundas tienen la siguientes características:
* Emplean id superior a 1'000.000, los nuevos típicamente emplean la 
  secuencia `msip_ubicacionpre_id_seq`
* El campo `pais_id` no es `NULL`
* El campo `lugar` tiene caracteres alfanuméricos y no es sólo espacios.
* Los campos `tsitio_id`, `latitud` o `longitud`  pueden o no tener un 
  valor.
* Si no tiene sitio el nombre consta del lugar barra y el nombre de la
  ubicacionpre correspondiente al de la división política del
  pais_id, departamento_id, municipio_id, centropoblado_id o vereda_id
  Por ejemplo 
Si tiene sitio no vacío





