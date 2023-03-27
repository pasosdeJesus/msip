
Al momento de este escrito las configuraciones que debe/puede
hacer un desarrollador, típicamente al momento de la instalación son:


* Formato de la fecha: Se configura en la variable de ambiente
  `FORMATO_FECHA` (típicamente en el archivo `.env`) sus valores típicos
  son:

  | Valor de FORMATO_FECHA | Representa | Ejemplo |
  |---|---|---|
  | `dd/M/yyyy`  | Formato colombiano | `26/Ene/2022` |
  | `yyyy-mm-dd` | Formato ISO | '2022-01-26' |

* Sexo : De una organización a otra pueden tener diferente convención 
  para el sexo de una persona.  Por ejemplo:
  * Femenino - Masculino - Sin Información
  * Mujer - Hombre - Sin Información
  * Mujer - Hombre - Intersexual - Sin Información
  O incluso convenciones confusas como la siguiente que puede confundirse
  con género:
  * Mujer - Hombre - Otro

  La experiencia nos ha mostrado que para validar convenciones de este estilo
  es mejor hacerlo a nivel de base de datos que ha nivel de Ruby on Rails.
  Por eso un lugar donde debe estar esta convención es en una restricción 
  del campo `sexo` de la tabla `msip_persona`.

  Así que para evitar definir varias veces una misma convención en 
  varias partes, la hemos dejado definida de manera única como la 
  restricción a nivel SQL con nombre `persona_sexo_check` del campo `sexo` 
  de la tabla `msip_persona`.  Y mantenemos herramientas para consultarla 
  de allí en `lib/msip/concerns/models/persona.rb`.

  En el momento soportamos dos tríos siguientes (en ese orden):

  | Mujer | Hombre | Sin Información |
  |---|---|---|
  | F | M | S |
  | M | H | S |
  | M | H | O |

  Para cambiarla debe ejecutarse una migración que establezca la
  restricción del estilo:

  BEGIN;
  ALTER TABLE msip_persona DROP CONSTRAINT IF EXISTS persona_sexo_check;
  UPDATE TABLE msip_persona SET sexo='H' WHERE sexo='M'; 
  UPDATE TABLE msip_persona SET sexo='M' WHERE sexo='F';
  UPDATE TABLE msip_persona SET sexo='S' WHERE sexo='S';
  ALTER TABLE msip_persona ADD CONSTRAINT persona_sexo_check
    CHECK (sexo = 'M' OR sexo = 'H' OR sexo = 'S');
  COMMIT;

