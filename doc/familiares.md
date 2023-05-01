La tabla `msip_persona` mantiene información de una persona que típicamente no
cambia (e.g. nombres, apellidos, fecha de nacimiento, sexo de nacimiento,
identificación).

Para registrar información cambiante sugerimos emplear tablas asociadas
a `msip_persona`.  Aunque en ocasiones si no se requiere un historial o
se requiere más velocidad para el acceso del último estado de información
posiblemente cambiante, pueden agregarse campos estilo `ultimoperfil`.


Para modelar relaciones familiares empleamos dos tablas más:
- `msip_relacion` con tipos de relaciones familiares entre 2 personas
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

Esto implica que cada relación tiene una relación inversa que se registra en el
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

Una propiedad es inverso compuesto con inverso es identidad.

No se permite relación de una persona consigo misma.

