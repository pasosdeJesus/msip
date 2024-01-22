La tabla `msip_persona` mantiene información de una persona que típicamente no
cambia (e.g. nombres, apellidos, fecha de nacimiento, sexo de nacimiento,
identificación).

Para registrar información cambiante sugerimos emplear tablas asociadas
a `msip_persona`.  Aunque en ocasiones si no se requiere un historial o
se requiere más velocidad para el acceso del último estado de información
posiblemente cambiante, pueden agregarse campos estilo `ultimoperfil`.


Para modelar relaciones familiares empleamos dos tablas más:
- `msip_trelacion` que es tabla basica con tipos de relaciones familiares entre 2 personas
- `msip_persona_trelacion` que relaciona dos personas con el tipo
  de relación familiar que tienen.

Las relaciones se identifican con 2 letras que de manera predeterminada
son:

| id |         nombre         |
|----|------------------------|
| AB | ABUELA(O) |
| AH | AHIJADA(O) |
| HE | HERMANA(O) |
| HI | HIJA(O) |
| HO | HIJASTRA(O) |
| NO | NIETA(O) |
| OO | SOBRINA(O) |
| PA | MADRE/PADRE |
| PD | MADRASTRA(PADRASTRO) |
| PM | PRIMA(O) |
| PO | MADRINA/PADRINO |
| SG | SUEGRA(O) |
| SI | SIN INFORMACIÓN |
| SO | ESPOSA(O)/COMPAÑERA(O) |
| TO | TIA(O) |
| YE | NUERA/YERNO |


Los campos de `msip_persona_trelacion` son:
- `persona1` id de la primera persona en la relación
- `persona2` id de la segunda persona en la relación
- `trelacion_id` relación de la primera con la segunda

Por ejemplo puede modelarse que ANA con id 1  es NIETA de GLORIA con id 2 con:
`(1, 2, 'NO')`

Con una relación de estas surge implícitamente otra relación que GLORIA es
ABUELA  de ANA i.e `(2, 1, 'AB')`.

Por esto cada tipo de relación tiene un tipo de relación inverso que se registra en el
campo `inverso` de `msip_trelacion` sin tener en cuenta el sexo de las
personas relacionadas:

| id | nombre | inverso | nombre inverso |
|----|------------------------|---------|------------------------|
| AB | ABUELA(O)              | NO      | NIETA(O) |
| AH | AHIJADA(O)             | PO      | MADRINA/PADRINO |
| HE | HERMANA(O)             | HE      | HERMANA(O) |
| HI | HIJA(O)                | PA      | MADRE/PADRE |
| HO | HIJASTRA(O)            | PD      | MADRASTRA(PADRASTRO) |
| NO | NIETA(O)               | AB      | ABUELA(O) |
| OO | SOBRINA(O)             | TO      | TIA(O) |
| PA | MADRE/PADRE            | HI      | HIJA(O) |
| PD | MADRASTRA(PADRASTRO)   | HO      | HIJASTRA(O) |
| PM | PRIMA(O)               | PM      | PRIMA(O) |
| PO | MADRINA/PADRINO        | AH      | AHIJADA(O) |
| SG | SUEGRA(O)              | YE      | NUERA/YERNO |
| SI | SIN INFORMACIÓN        | NULL  | NULL |
| SO | ESPOSA(O)/COMPAÑERA(O) | SO      | ESPOSA(O)/COMPAÑERA(O) |
| TO | TIA(O)                 | OO      | SOBRINA(O) |
| YE | NUERA/YERNO            | SG      | SUEGRA(O) |


Un par de propiedades de los tipos de relación:
* Todo tipo de relación (r) debe tener un inverso (-r)
* Dada un tipo de relación, el inverso de su inverso es el mismo tipo -(-r)=r

En msip estas propiedades se validan en el modelo y para el conjunto de registros.

Y en personas:
* Una persona no es familiar de si misma.
* Para un par de personas p1,p2 debe haber a lo sumo una relación
* Si p1 se relaciona con tipo de relacion r con p2,  debe relacionarse p2 con tipo de relacion inversa -r con p1.

En msip las primeras propiedad se validan la segunda se garantiza con triggers que se han implemetando para operaciones de creacion, eliminacion y modificacion de la tabla `persona_trelacion`.
