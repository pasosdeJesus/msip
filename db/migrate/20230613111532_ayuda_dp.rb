# frozen_string_literal: true

class AyudaDp < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='1'; -- CÉDULA DE CIUDADANÍA
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='2'; -- CÉDULA DE IDENTIDAD
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='5'; -- CONTRASEÑA
      UPDATE msip_tdocumento SET ayuda='Dígitos un guion y dígitos. Por ejemplo 1344-4232' WHERE id='100'; -- CÉDULA DE CIUDADANIA DE ECUADOR
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='3'; -- CÉDULA DE RESIDENTE
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='4'; -- CÉDULA DE TRANSEUNTE
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='8'; -- PARTIDA DE NACIMIENTO
      UPDATE msip_tdocumento SET ayuda='Una letra, un guión y una serie de dígitos. Por ejemplo A-3288221' WHERE id='6'; -- DOCUMENTO PROVISIONAL
      UPDATE msip_tdocumento SET ayuda='Cualquier cadena (sin restricción en formato)' WHERE id='7'; -- OTRO
      UPDATE msip_tdocumento SET ayuda='Mayúsculas seguidas de digitos. Por ejemplo ARN1864' WHERE id='9'; -- PASAPORTE
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='10'; -- REGISTRO CIVIL
      UPDATE msip_tdocumento SET ayuda='Digitos opcionalmente seguidos de letras mayúsculas. Por ejemplo 323948A' WHERE id='11'; -- SIN DOCUMENTO
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='12'; -- TARJETA DE IDENTIDAD
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='13'; -- CÉDULA DE EXTRANJERÍA
      UPDATE msip_tdocumento SET ayuda='De la forma AÑO-MES-DIA-ID, por ejemplo 2018-10-21-1334 o 2017-3-2-AB33' WHERE id='15'; -- ACTA DE NACIMIENTO - VEN
      UPDATE msip_tdocumento SET ayuda='Dígitos un guion y digitos. Por ejemplo 1344-4232' WHERE id='100'; -- CÉDULA DE CIUDADANIA DE ECUADOR
      UPDATE msip_tdocumento SET ayuda='Solo dígitos. Por ejemplo 323948' WHERE id='101'; -- PRECÉDULA
    SQL
  end

  def down
    execute(<<-SQL)
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='1'; -- CÉDULA DE CIUDADANÍA
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='2'; -- CÉDULA DE IDENTIDAD
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='3'; -- CÉDULA DE RESIDENTE
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='4'; -- CÉDULA DE TRANSEUNTE
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='5'; -- CONTRASEÑA
      UPDATE msip_tdocumento SET ayuda=NULL WHERE id=6; -- DOCUMENTO PROVISIONAL
      UPDATE msip_tdocumento SET ayuda='Una letra, un guión y una serie de dígitos. Por ejemplo A-3288221' WHERE id='6'; -- DOCUMENTO PROVISIONAL
      UPDATE msip_tdocumento SET ayuda='Cualquier cadena sirve de identificación (sin restricción en formato)' WHERE id='7'; -- OTRO
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='8'; -- PARTIDA DE NACIMIENTO
      UPDATE msip_tdocumento SET ayuda='Debe constar de letras mayúsculas seguidas de dígitos. Por ejemplo DSS-1344' WHERE id=9; -- PASAPORTE
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='10'; -- REGISTRO CIVIL
      UPDATE msip_tdocumento SET ayuda='Debe constar de digitos opcionalmente seguidos de letras mayúsculas. Por ejemplo 323948A' WHERE id='11'; -- SIN DOCUMENTO
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='12'; -- TARJETA DE IDENTIDAD
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='13'; -- CÉDULA DE EXTRANJERÍA
      UPDATE msip_tdocumento SET ayuda='Debe ser de la forma AÑO-MES-DIA-ID, por ejemplo 2018-10-21-1334 o 2017-3-2-AB33' WHERE id='15'; -- ACTA DE NACIMIENTO - VEN
      UPDATE msip_tdocumento SET ayuda='Debe constar de dígitos un guion y digitos. Por ejemplo 1344-4232' WHERE id='100'; -- CÉDULA DE CIUDADANIA DE ECUADOR
      UPDATE msip_tdocumento SET ayuda='Debe constar solo de digitos. Por ejemplo 323948' WHERE id='101'; -- PRECÉDULA
    SQL
  end
end
