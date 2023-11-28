# División político administrativa y ubicaciones predefinidas

## División político administrativa

Para modelar la división político administrativa de diversos países
usamos 4 niveles:

| Nivel | Urbano o Rural | Tabla (con prefijo `msip_`)|
|---|---|---|
| 1 | Ambos | pais |
| 2 | Ambos | departamento |
| 3 | Ambos | municipio |
| 4 | Urbano | centropoblado |
| 4 | Rural | vereda |

Como fuentes de información para el caso de Colombia hemos empleado 
principalemente el DIVIPOLA publicado por el DANE (ver 
<https://geoportal.dane.gov.co/geovisores/territorio/consulta-divipola-division-politico-administrativa-de-colombia/>), 
que suele tener varias actualizaciones al año que procuramos
seguir y publicar como actualización de msip al menos una vez al año 
que solemos comentar y publicar con un artículo en:
https://gitlab.com/pasosdeJesus/msip/-/wikis/home


Para el caso de Venezuela empleamos datos recolectados por Randolf Laverde
en 2014.

Para el caso de Honduras empleamos datos del Censo 2013 del Instuto Nacional de
Estadística de Honduras gestionados por Oslin George.

Para el listado de países hemos empleado especialmente
https://www.iso.org/obp/ui/#search/code/

Mantenemos un archivo histórico de la información que hemos usado como fuente
así como las comunicaciones que hemos tenido para reportar errores y 
proponer correcciones (particularmente derechos de petición y sus respuesta 
al DANE y al IGACC) en:
https://gitlab.com/pasosdeJesus/division-politica


## Ubicaciones predefinidas (ubicacionpre)

Su objetivo es permitir reusar lugares geográficos previamente empleados en un 
sistema de información.

Por ejemplo Tierra Amarilla es un sector rural en el municipio de San José de
Apartado en Antioquia, Colombia, donde los paramilitares han montado
retenes en muchas oportunidades para violentar a la población.  
En un sistema de información sin  ubicaciones predefinidas cada caso en 
Tierra Amarilla tendría duplicado ese lugar, con ubicaciones predefinidas 
sería posible tener un solo lugar y reusarlo en los diversos casos, 
por ejemplo mediante autocompletación.

Hemos experimentado este concepto en el sistema de información del JRS-Colombia
con la siguiente presentación visual:



Las ubicaciones predefinidas pueden ser bien (1) **divisiones político
administrativas** cuando corresponden a  divisiones político-administrativas 
definidas en las tablas básicas país, departamento, municipio, 
centro poblado o vereda o bien (2) **lugares** cuando corresponden
a lugares dentro de una división político administrativa.

Las ubicaciones predefinidas también pueden ser (1) **compartidas** cuando
se definen y mantienen en msip para los diversos sistemas de información
que lo usan o (2)  **propias** de un sistema de información.

Al momento de este escrito en msip se definen y mantienen con actualizaciones
periódicas sólo divisiones político administrativas y sus correspondiendtes
ubicacionespre, así que al momento las ubicacionespre que son lugares siempre 
son propias del sistema donde se especifican y sólo pueden agregarse desde
la interfaz por ejemplo de caso o donde se usan. 

Un sistema de información puede tener divisiones político administrativas 
compartidas y divisiones político administrativas propias (si los 
administradores del sistema han hecho por ejemplo adiciones a las tablas 
básicas país, departamento, municipio, centro poblado o vereda) y en
tales casos deberían crearse automáticamente ubicacionespre correspondientes.

Como las divisiones político administrativas compartidas son responsabilidad
de Pasos de Jesús (desarrollador de msip) no se recomienda modificarlas (si
requieren mejoras agradecemos contribuciones en el repositorio de msip
<https://gitlab.com/pasosdeJesus/msip> para que mejoren todos los sistemas
de información que lo usan).


# Consistencia entre tablas básicas de divisiones político administrativa y 
  ubicacionespre

Como la información de la división política (i.e. tablas básicas
país, departamento, municipio, centro poblado y vereda) queda "replicada" en 
ubicacionespre, debe garantizarse que la replica está siempre
actualizada (por ejemplo que al cambiar el nombre
de un centro poblado también cambie en las ubicacionespre que lo usan).

No se premiten cambios a las tablas básicas desde ubicacionespre por lo que
sólo debe mantenerse consistencia en el escenario de cambios a tablas
básicas y de su "replica" en ubicacionespre.


## Divisiones político adminsitrativas compartidas

Se mantienen bien en 
(1) archivos semilla SQL de msip que se usan al instalar nuevos sistemas de 
    información.
(2) migraciones de msip que usadas en actualizaciones de sistema de
    información existente (por ejemplo en Colombia para actualizar DIVIPOLA 
    por sus cambios frecuentes) que pueden crear, actualizar y esporadicamente
    eliminar registros --aunque lo típico será deshabilitarla.

A nivel de base de datos se diferencia porque tienen identificaciones 
inferiores a unos valores cota:

| tabla | cota de id para registros comunes |
|---|---|
| pais | 1.000 |
| departamento | 10.000 |
| municipio | 100.000 |
| centopoblado | 1'000.000 |
| vereda | 1'000.000 | OJO
| ubicacionpre | 10'000.000 | OJO

Los usuarios de un sistema de información particular tienen posibilidad de 
modificar esta información desde las tablas básicas país, departamento, 
municipio, centropoblado y vereda.  No se recomienda hacerlo, pero de
hacerlo se buscará garantizar de ubicacionespre.



# Especificación técnica para realizar operaciones

Para implementar la funcionalidad de ubicacionpre se emplea la tabla 
`msip_ubicacionpre` cuyos campos son:

| nombre | tipo | cotejacion | puede ser null | predeterminado | llave foranea
de |
|---|---|---|---|---|
| id               | bigint                      |             | not null | nextval('msip_ubicacionpre_id_seq'::regclass)|
| nombre           | character varying(2000)     | es_co_utf_8 | not null | |
| nombre_sin_pais  | character varying(500)      |             |          | |
| pais_id          | integer                     |             | not null OJO | | msip_pais |
| departamento_id  | integer                     |             |          | | msip_departamento |
| municipio_id     | integer                     |             |          | | msip_municipio |
| centropoblado_id | integer                     |             |          | | msip_centropoblado
| vereda_id        | integer                     |             |          | | msip_vereda |
| lugar            | character varying(500)      |             |          | | |
| sitio            | character varying(500)      |             |          | | |
| tsitio_id        | integer                     |             |          | | msip_tsitio |
| latitud          | double precision            |             |          | | |
| longitud         | double precision            |             |          | | |
| created_at       | timestamp without time zone |             | not null | | |
| updated_at       | timestamp without time zone |             | not null | | |


Además teniendo en cuenta que:
* `nombre` es único.
* `nombre_sin_pais` corresponde a `nombre` pero quitandole el país.
* Los campos `latitud`, `longitud` y `tsitio_id` tendrán un valor 
  predeterminado para esos campos donde se use en el sistema de información
  que el usuario podrá cambiar sin alterar los de la ubicacionpre.
  (por ejemplo `caso_ubicacionpre` debería tener al menos
  `caso_id`, `ubicacionpre_id`, `tsitio_id`, `latitud` y `longitud` que
   se presenten inicialmente con lo proveniente de ubicacionpre pero que
   el usuario podrá modificar).

Las ubicacionespre de registros comunes se caracterizan por:
* Emplear `id` inferior a 1'000.000

Las ubicacionespre de diviones político administrativas se caracterizan
por:
* Tener en `NULL` los campos `lugar` y `sitio`
* Los países tienen en `NULL` los campos `departamento_id`,  `municipio_id`,
  `centropoblado_id`, `vereda_id`, `tsitio_id`. La latitud y la longitud 
  corresponden al proveniente de la tabla básica país.  
  El nombre corresponde al del país e.g. Venezuela. El `nombre_sin_pais` es ''
* Los departamentos tienen en `NULL` los campos `municipio_id`,
  `centropoblado_id`, `vereda_id`, `tsitio_id`. La latitud y la longitud 
  se copian del registro en la tabla básica.
  El nombre consta del departamento y el país separados por barra de
  división, e.g. Arauca / Colombia
* Los municipios tienen en `NULL` los campos `centropoblado_id`, 
  `vereda_id`, `tsitio_id`. La latitud y la longitud  se copian 
  del registro de la tablas básica municipio.
  El nombre consta del municipio, el departamento y el país separados 
  por barras de división, e.g. Angelópolis / Antioquia / Colombia
* Los centros poblados tienen en `NULL` el campo `vereda_id`. 
  El campo `tsitio_id` es 2 (i.e. URBANO). 
  La latitud y la longitud se copian de la tabla básica.
  El nombre consta del centro poblado, el municipio, el departamento 
  y el país separados por barras de división, e.g. 
  Paloma / Tucupita / Delta Amacuro / Venezuela
* Las veredas tienen en `NULL` el campo `centropoblado_id`. 
  El campo `tsitio_id` es 3 (i.e. RURAL). 
  La latitud y la longitud se copian de la tabla básica.
  El nombre consta de la palabra `Vereda ` seguida del nombre
  de la vereda, el municipio, el departamento y el país separados por 
  barras de división, e.g. Vereda Los Alpes / Saravena / Arauca / Colombia


Las ubicacionespre de registros propios se caracterizan por:
* Emplear un id superior o igual a 1'000.000, los nuevos típicamente emplean 
  la secuencia `msip_ubicacionpre_id_seq`

Los ubicacionespre de lugares se caracterizan por:
* El campo `lugar` tiene caracteres alfanuméricos y no es sólo espacios.
* Al menos el campo `pais_id` no es `NULL`.  La división política que
  contiene al lugar será la mayor que no sea `NULL` (por ejemplo si
  `municipio_id` no es NULL pero `centropoblado_id` y `vereda_id` son 
   `NULL` se especifica un lugar dentro del municipio).
* Los campos `tsitio_id`, `latitud` o `longitud`  pueden o no tener un 
  valor.
* Si no tiene sitio el nombre consta del lugar barra y el nombre de la
  ubicacionpre correspondiente al de la división política del
  pais_id, departamento_id, municipio_id, centropoblado_id o vereda_id
  Por ejemplo 
* Si tiene sitio el nombre será como el del lugar precedido del sitio
  y una barra.





* Creación de nuevos registros:  Cuando se agregue un 
  pais/departamento/municipio/centropoblado con identificación menor a la
  cota para registros comunes debe crearse una ubicacionpre 
  con identificación < 1´000.0000 por ejemplo con id:
  
        SELECT MIN(id+1) FROM msip_ubicacionpre 
          WHERE (id+1) NOT IN (SELECT id FROM msip_ubicacionpre) 
          AND id<1000000;

  Bien en los datos semilla o bien en migraciones debe corresponder a
  una dobla inserción, primero en la tabla 
  pais/departamento/municipio/centropoblado/vereda y después en la
  tabla ubicacionpre con la id que se le asigna.  Todo 
  pais/departamento/municipio/centropoblado/vereda debe tener una única
  ubicacionpre con null en los campos de menor nivel o si es centropoblado vereda
en null y tsitio_id en urbano o si es vereda centropoblado en null y tsitio_id
en rural.  
* R: Se lee cada una de manera independiente
* U: Cuando se actualice nombre de un
  pais/departamento/municipio/centropoblado/vereda deben actualizarse los
nombres de los diversos registros de ubicacionpre con ese.
* D: Cuando se elimine un pais/departamento/municipio/centropoblado deben
  eliminarse las ubicacionespre que lo incluyan.

## Divisiones político administrativas propias de un sistema de información

Correponde a nuevos registros en las tablas básicas país, departamento,
municipio, centropoblado y vereda que se hacen desde el sistema de
información con la interfaz tipica para esto, listado, botones nuevo,
editar y eliminar.


