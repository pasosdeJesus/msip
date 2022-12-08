class RenombraRestriccionesSipMsip < ActiveRecord::Migration[7.0]

  include Msip::SqlHelper

  RES=[
    ['msip_clase', 'sip_clase_id_municipio_id_clalocal_key',
        'msip_clase_id_municipio_id_clalocal_key'],
    ['msip_departamento', 'sip_departamento_id_key',
        'msip_departamento_id_key'],
    ['msip_departamento', 'sip_departamento_id_pais_id_deplocal_unico',
        'msip_departamento_id_pais_id_deplocal_unico'],
    ['msip_municipio', 'sip_municipio_id_departamento_fkey',
        'msip_municipio_id_departamento_fkey'],
    ['msip_municipio', 'sip_municipio_id_departamento_id_munlocal_unico',
        'msip_municipio_id_departamento_id_munlocal_unico'],
    ['msip_pais', 'sip_pais_codiso_unico',
        'msip_pais_codiso_unico'],
    ['msip_persona_trelacion', 'sip_persona_trelacion_id_key',
        'msip_persona_trelacion_id_key'],
    ['msip_persona_trelacion', 
         'sip_persona_trelacion_persona1_persona2_id_trelacion_key',
         'msip_persona_trelacion_persona1_persona2_id_trelacion_key'],
    ['msip_persona_trelacion', 'sip_persona_trelacion_id_key',
        'msip_persona_trelacion_id_key'],
    ['msip_persona_trelacion', 
     'sip_persona_trelacion_persona1_persona2_id_trelacion_key1',
     'msip_persona_trelacion_persona1_persona2_id_trelacion_key1'],
  ]

  def up
    RES.each do |tr| 
      if existe_restricción_pg?(tr[1])
        renombrar_restricción_pg( tr[0], tr[1], tr[2])
      end
    end
  end
  def down
    RES.reverse.each do |tr| 
      if existe_restricción_pg?(tr[2])
        renombrar_restricción_pg( tr[0], tr[2], tr[1])
      end
    end
  end

end
