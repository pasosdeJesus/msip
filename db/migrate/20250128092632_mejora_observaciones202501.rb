class MejoraObservaciones202501 < ActiveRecord::Migration[7.2]
  def up
    execute <<-SQL

      -- Mejora observaciones de municipios
      UPDATE msip_municipio SET observaciones=trim(observaciones || '.')
        WHERE observaciones ~ '[^.]$';

      UPDATE msip_municipio SET observaciones = trim(regexp_replace(observaciones,
        'Municipio deshabilitado .*en DIVIPOLA 2019',
        'Municipio deshabilitado en DIVIPOLA 2019'))
        WHERE observaciones LIKE '%Municipio deshabilitado en DIVIPOLA 2019. Municipio deshabilitado en DIVIPOLA 2019%';

      UPDATE msip_municipio SET observaciones = trim(replace(observaciones,
        'Centro poblado con nombre cambiado', 'Municipio con nombre cambiado'))
        WHERE observaciones LIKE '%Centro poblado con nombre cambiado%';

      UPDATE msip_municipio SET observaciones = trim(regexp_replace(observaciones,
        'Municipio con nombre cambiado durante revisión .*de DIVIPOLA 2019. Antes era ',
        'Municipio con nombre cambiado durante reivisión de DIVIPOLA 2019, antes era '))
        WHERE observaciones LIKE '%Municipio con nombre cambiado durante revisión de DIVIPOLA 2019. Antes%';

      -- Mejora observaciones de centros poblados
      UPDATE msip_centropoblado SET observaciones=trim(observaciones || '.')
        WHERE observaciones ~ '[^.]$';

      UPDATE msip_centropoblado SET observaciones = trim(regexp_replace(observaciones,
        'Centro poblado deshabilitado .*en DIVIPOLA 2019',
        'Centro poblado deshabilitado en DIVIPOLA 2019'))
        WHERE observaciones LIKE '%Centro poblado deshabilitado en DIVIPOLA 2019. Centro poblado deshabilitado en DIVIPOLA 2019%';

      UPDATE msip_centropoblado SET observaciones = trim(regexp_replace(observaciones,
        'Nombre de DIVIPOLA 2019, .*el anterior era ', 'Nombre de DIVIPOLA 2019, el anterior era'))
        WHERE observaciones ~ 'Nombre de DIVIPOLA 2019.*Nombre de DIVIPOLA 2019';

      UPDATE msip_centropoblado SET observaciones = trim(regexp_replace(observaciones,
        'Rehabilitado por DIVIPOLA 2019.*Rehabilitado por DIVIPOLA 2019',
        'Rehabilitado por DIVIPOLA 2019'))
        WHERE observaciones ~ 'Rehabilitado por DIVIPOLA 2019.*Rehabilitado por DIVIPOLA 2019';

      UPDATE msip_centropoblado SET observaciones = trim(regexp_replace(observaciones,
        'No está en DIVIPOLA 2019.*No está en DIVIPOLA 2019',
        'No está en DIVIPOLA 2019'))
        WHERE observaciones ~ 'No está en DIVIPOLA 2019.*No está en DIVIPOLA 2019';

      UPDATE msip_centropoblado SET observaciones = trim(regexp_replace(observaciones,
        'No está en DIVIPOLA 2020.*No está en DIVIPOLA 2020',
        'No está en DIVIPOLA 2020'))
        WHERE observaciones ~ 'No está en DIVIPOLA 2020.*No está en DIVIPOLA 2020';
      
      UPDATE msip_centropoblado SET observaciones = trim(regexp_replace(observaciones,
        'el anterior era', 'el anterior era '))
        WHERE observaciones ~ 'el anterior era[^ ]';
    SQL
  end
  def down
    execute <<-SQL
    SQL
  end
end
