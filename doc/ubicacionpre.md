# División político administrativa y ubicaciones predefinidas

## 1. División político administrativa

Para modelar la división político administrativa de diversos países
usamos 4 niveles especificados en 5 tablas básicas:

| Nivel | Urbano o Rural | Tabla Básica (con prefijo `msip_`)|
|---|---|---|
| 1 | Ambos | `pais` |
| 2 | Ambos | `departamento` |
| 3 | Ambos | `municipio` |
| 4 | Urbano | `centropoblado` |
| 4 | Rural | `vereda` |

Como fuentes de información para el caso de Colombia hemos empleado 
principalemente el DIVIPOLA y el Mapa Veredal publicados por el DANE (ver 
<https://geoportal.dane.gov.co/geovisores/territorio/consulta-divipola-division-politico-administrativa-de-colombia/> y 
<https://geoportal.dane.gov.co/servicios/descarga-y-metadatos/descarga-nivel-de-referencia-de-veredas/#gsc.tab=00>).
El DIVIPOLA suele tener varias actualizaciones al año que procuramos
seguir y publicar como actualización de msip al menos una vez al año 
con nuevas versiones de msip y un par de artículos por cada actualización
al DIVIPOLA en: <https://gitlab.com/pasosdeJesus/msip/-/wikis/home>

Para el caso de Venezuela empleamos datos recolectados por Randolf Laverde
en 2014.

Para el caso de Honduras empleamos datos del Censo 2013 del Instuto Nacional de
Estadística de Honduras gestionados por Oslin George.

Para el listado de países hemos empleado especialmente
https://www.iso.org/obp/ui/#search/code/

Las siluetas (o polígonos) de diversas divisiones político administrativa 
solemos obtenerlas, actualizarlas y retroalimentar https://openstreetmap.org

Mantenemos un archivo histórico de la información que hemos usado como fuente
así como las comunicaciones que hemos tenido para reportar errores y 
proponer correcciones (particularmente derechos de petición y sus respuesta 
al DANE y al IGACC) en:
https://gitlab.com/pasosdeJesus/division-politica


## 2. Ubicaciones predefinidas (ubicacionpre)

Su objetivo es permitir reusar lugares geográficos previamente empleados en un 
sistema de información.

Por ejemplo Tierra Amarilla es un sector rural en el municipio de San José de
Apartado en Antioquia, Colombia, donde los paramilitares han montado
retenes en muchas oportunidades para violentar a la población.  
En un sistema de información sin  ubicaciones predefinidas cada caso en 
Tierra Amarilla tendría duplicado ese lugar, con ubicaciones predefinidas 
sería posible tener un solo lugar y reusarlo en los diversos casos, 
por ejemplo mediante autocompletación

Hemos experimentado este concepto (sin veredas) con un prototipo en el 
sistema de información del JRS-Colombia que tiene la siguiente 
presentación visual:
![Prototipo para usar-agregar ubicaciones predefinidas en JRS-Colombia](https://gitlab.com/pasosdeJesus/msip/-/raw/main/doc/prototipo-ubicacionpre-jrscol.png)


Tras especificar país y tal vez otros niveles de la división político
administrativa, en el campo lugar al escribir se hace una búsqueda
de lugares predefinidos dentro de la división política especificada que 
coincida con lo tecleado y sus resultados se presentan 
para permitir seleccionar alguno y en caso de elegir uno se completan
automáticamente los diversos campos a la vez que se se reusa la misma
ubicación empleada en otros casos.  Si no hay un resultado coincidente
con el lugar que se especifica o no se elige ninguno se crea una nueva
ubicacionpre que estará disponibles en autocompletaciones posteriores.

Las ubicaciones predefinidas pueden ser bien (1) **divisiones político
administrativas** cuando corresponden a  divisiones político administrativas 
definidas en las tablas básicas país, departamento, municipio, 
centro poblado o vereda o bien (2) **lugares** cuando corresponden
a lugares dentro de una división político administrativa.

Las ubicaciones predefinidas también pueden ser (1) **comunes** cuando
se definen y mantienen en msip para los diversos sistemas de información
que lo usan o (2)  **propias** de un sistema de información.

Al momento de este escrito en msip se definen y mantienen con actualizaciones
periódicas sólo divisiones político administrativas y sus correspondientes
ubicacionespre, así que al momento las ubicacionespre que sean lugares siempre 
son propias del sistema donde se especifican y sólo pueden agregarse desde
la interfaz donde se usan. 

Un sistema de información puede tener divisiones político administrativas 
comunes y divisiones político administrativas propias (si los 
administradores del sistema han hecho por ejemplo adiciones a las tablas 
básicas país, departamento, municipio, centro poblado o vereda) y en
tales casos deberían crearse automáticamente ubicacionespre correspondientes.

Como las divisiones político administrativas comunes son responsabilidad
de Pasos de Jesús (desarrollador de msip) no se recomienda modificarlas (si
requieren mejoras agradecemos contribuciones en el repositorio de msip
<https://gitlab.com/pasosdeJesus/msip> para que mejoren todos los sistemas
de información que lo usan).


## 3. Consistencia entre tablas básicas de divisiones político administrativa y ubicacionespre

Como la información de la división política (i.e. tablas básicas
país, departamento, municipio, centro poblado y vereda) queda referencida y
al menos el nombre "replicado" múltiples veces en 
ubicacionespre, debe garantizarse que la replica está siempre
actualizada (por ejemplo que al cambiar el nombre
de un centro poblado también cambie en las ubicacionespre que lo usan).

No se premiten cambios a las tablas básicas desde ubicacionespre por lo que
sólo es necesario mantener consistencia en el escenario de cambios a tablas
básicas y de sus referencias en ubicacionespre.


### 3.1 Divisiones político adminsitrativas comunes

Se mantienen bien en 
(1) archivos semilla SQL de msip que se usan al instalar nuevos sistemas de 
    información.
(2) migraciones de msip usadas en actualizaciones de sistemas de
    información existentes (por ejemplo para actualizar DIVIPOLA  de Colombia
    por sus cambios frecuentes) que pueden crear, actualizar y esporadicamente
    eliminar registros --aunque lo recomendado no es eliminar
    sino deshabilitarla diligenciando una fecha de deshabilitación.

A nivel de base de datos se diferencia porque tienen identificaciones 
inferiores a unos valores cota:

| tabla | cota de id para registros comunes |
|---|---|
| pais | 1.000 |
| departamento | 10.000 |
| municipio | 100.000 |
| centopoblado | 1'000.000 |
| vereda | 1'000.000 |
| ubicacionpre | 10'000.000 |

Los usuarios de un sistema de información particular tienen posibilidad de 
modificar esta información desde las tablas básicas país, departamento, 
municipio, centropoblado y vereda.  No se recomienda hacerlo, pero lo
que se permita modificar deberá actualizarse automáticamente
en su "respaldo" en ubicacionpre.


## 4. Especificación técnica para realizar operaciones

Para implementar la funcionalidad de ubicacionpre en PostgreSQL se emplea 
la tabla `msip_ubicacionpre` cuyos campos son:

| nombre | tipo | cotejacion | puede ser null | predeterminado | llave foranea |
|---|---|---|---|---|---|
| id | bigint | | not null | nextval('msip_ubicacionpre_id_seq'::regclass)|
| nombre           | character varying(2000)     | es_co_utf_8 | not null | |
| nombre_sin_pais  | character varying(500)      |             |          | |
| pais_id          | integer                     |             | not null | | con `id` de `msip_pais` |
| departamento_id  | integer                     |             |          | | `(departamento_id, pais_id)` con `(id, pais_id)` de `msip_departamento` |
| municipio_id     | integer                     |             |          | | `(municipio_id, departamento_id)` con `(id, departamento_id)` de `msip_municipio` |
| centropoblado_id | integer                     |             |          | | `(centropoblado_id, municipio_id)` con `(id, municipio_id)` de `msip_centropoblado` |
| vereda_id        | integer                     |             |          | | `(vereda_id, municipio_id)` con `(id, municipio_id)` de `msip_vereda` |
| lugar            | character varying(500)      |             |          | | |
| sitio            | character varying(500)      |             |          | | |
| tsitio_id        | integer                     |             |          | | con `id` de `msip_tsitio` |
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

Para que cada registro de las tablas básicas de división política
corresponda a una sóla ubicacionpre de divisiones político administrativas, 
estas se caracterizan por:
* Tener en `NULL` los campos `lugar` y `sitio`
* Los países tienen en `NULL` los campos `departamento_id`,  `municipio_id`,
  `centropoblado_id`, `vereda_id`, `tsitio_id`. La latitud y la longitud 
  provienen de la tabla básica país.  
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
* Emplear un id superior o igual a 10'000.000, los nuevos típicamente emplean 
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
  Por ejemplo Tierra Amarilla / San José de Apartado / Antioquia / Colombia
* Si tiene sitio el nombre será como el del lugar precedido del sitio
  y una barra.



### 4.1 Lugares

#### 4.1.1 Creación 

No se debe permitir crear ubicacionespre de divisiones político 
administrativas sino sólo agregar lugares nuevos.

Si el nombre de la ubicacionpre no existe, debe crear tanto una nueva 
ubicacionpre como un registro que relaciona una entidad con la ubicacionpre 
y que también debe tener `tsitio_id`, `latitud` y `longitud` 
(e.g `caso_ubicacion`) y almacenar esta información en ambos registros 
nuevos.

Si se pretende agregar una ubicacionpre con nombre duplicado debería no
permitir y alertar que bien se autocompleta para reusar la que existe
o se cambia lugar y/o sitio para darle un nombre diferente.

La sincronía entre ubicacionpre y entidad_ubicacion parece más natural 
a nivel de rails que a nivel de base de datos.

#### 4.1.2 Actualización

No permite cambiar id.

No requiere sincronizar.

No permite dejar en blanco el campo lugar.

No permite actualizar el nombre de forma que quede repetida, sino debe alertar.

Nos parece usable que el control quede directamente ligado con 
la ubicacionpre para todos los campos --excepto tsitio_id, latitud,
longitud, pero que use los valores que se suministren en ubicacionpre
si allí son NULL.


#### 4.1.3 Eliminación

No requiere sincronizar con división pa. Deben eliminarse también
registros de los diversas entidades donde se usen --o al menos dejarlos
en null.

Nos parece más usable brindar el mecanismo de fecha de deshabilitación
y tal vez al momento de presentar una ubicacionpre deshabilitada
indicarlo.

Implementar la deshabilitación y/o la eliminación sería más típico
de msip con una presentación estándar de tablas básicas para ubicacionpre 
--que sólo requeriría observaciones, fechacreacion y fechadeshabilitación
para ser como una tabla básica.


### 4.2 Divisiones político administrativas

No puede crearse/actualizarse/eliminarse desde un control para 
ubicacionpre  ni desde una tabla básica ubicacionpre, debe hacerse 
como efecto de agregar/actualizar/eliminar registros a una de las tablas 
básicas de división político administrativa país, departamento, 
municipio, centro poblado o vereda.

##### 4.2.1 Propias

No deben ser operaciones típicas pero podrían ser realizadas por ejemplo
por un administrador desde la interfaz de tablas básicas para País, 
Departamento, Municipio, Centro Poblado o Vereda.

##### 4.2.1.1 Creación

Con el botón nuevo, tras agregar un registro debe quedar con una 
identificación superior a la cota que diferencia registros comunes 
de propios, debe agregarse la respectiva ubicacionpre con 
identificación > 10'000.000 tipicamente siguiendo e incrementando 
la secuencia `msip_ubicacionpre_id_seq` (que ocurre automaticamente 
cuando no se especifica `id` en PostgreSQL).

##### 4.2.1.2 Actualización

Con el botón editar desde la tabla básica de una división política.

Un cambio en nombre de una división política requiere cambiar nombre
de todas las ubicaciones pre que la incluyan (tanto en campos nombre como
en nombre_sin_pais).

Un cambio en latitud o longitud de una división política requiere cambio
en la ubicacionpre que le corresponde.  Sería bueno verificar que el 
punto queda dentro de la silueta de la división política cuando la
hay.
 
Una deshabilitación de una división política debería implicar la 
deshabilitación de todas las divisiones políticas contenidas y de las
ubicacionespre que referencien la que se deshabilita.

Un cambio en un id requiere cambiar todas las ubicaciones que lo referencian 
--creando copia referenciando copia y después eliminando el de la id no
requerida.  Esto podría hacerse más práctico en una migración desde las fuentes
del sistema de información, pero no desde la interfaz que por política
no permite cambiar el campo id.

Un cambio en una referencia a una división contenedora (por ejemplo 
municipio_id en un centro poblado) requiere cambio en todas las ubicacionespre
que referencia y se simplifica haciéndolo en simultaneo con un cambio en id
y por tanto desde las fuentes.  Por eso no se permite edición de estos campos
en registros ya creados.

Los cambios a otros campos como observaciones, tipos, otros códigos 
no afectan ubicacionespre y un administrador podría hacerlos.

##### 4.2.1.3 Eliminación

En general es más recomendable una deshabilitación.

Debería hacerse en simultaneo con:
* Eliminación de divisiones políticas contenidas
* Eliminación de ubicacionespre que referencian la que se elimina o las 
  contenidas.

El caso simple en el que se debe poder hacer es cuando se acaba de 
crear por ejemplo un pais para probar y se requiere eliminar, se identifica
porque no hay divisiones políticas contenidas y sólo hay una ubicacionpre 
asociada a la división política que se elimina en simultaneo.

Eliminaciones más complejas de manera automática deben hacerse con 
migraciones desde las fuentes del sistema.


#### 4.2.2 Comunes

##### 4.2.2.1 Creación

Esta operación no se espera de parte de usuarios ni administradores sino de 
desarrolladores de msip.

* Cuando se agregue un pais/departamento/municipio/centropoblado con 
  identificación menor a la cota para registros comunes debe crearse una 
  ubicacionpre con identificación < 10´000.0000 por ejemplo con id:
  
        SELECT MAX(id+1) FROM msip_ubicacionpre 
          WHERE (id+1) NOT IN (SELECT id FROM msip_ubicacionpre) 
          AND id<10000000;

  (no usamos MIN en el ejemplo anterior porque no deben sobreescribirse posibles
  identificaciones usadas para datos deshabilitados   --que pueden cambiar de un
  sistema a otro, pues nuevos sistemas deben comenzar con toda su división p.a. y
  todas sus ubicaciones pre habilitadas)
  Bien en los datos semilla o bien en migraciones debe corresponder a
  una doble inserción, primero en 
  pais/departamento/municipio/centropoblado/vereda y después en la
  tabla ubicacionpre con la id que se le asigna. 
 
##### 4.2.2.2 Actualización

Para la migración tener en cuenta las observaciones para
divisiones políticas propias.


##### 4.2.2.3 Eliminación

Para la migración tener en cuenta las observaciones para
divisiones políticas propias.
Debería hacerse en simultaneo con:
* Eliminación de ubicacionespre que usen la división política asi como de sus
  registros en entidad_ubicacionpre
* Eliminación de divisiones políticas contenidas y de sus respectivas

Es más recomendable una deshabilitación.


