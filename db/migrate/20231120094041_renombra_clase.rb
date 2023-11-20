# frozen_string_literal: true

class RenombraClase < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper
  def up
    if existe_restricción_pg?("tclase_pkey")
      renombrar_restricción_pg("msip_tclase", "tclase_pkey", "msip_tclase_pkey")
    end
    rename_table :msip_tclase, :msip_tcentropoblado
    if existe_restricción_pg?("clase_pkey")
      renombrar_restricción_pg("msip_clase", "clase_pkey", "msip_clase_pkey")
    end
    rename_table :msip_clase, :msip_centropoblado
    if existe_restricción_pg?("msip_tclase_pkey")
      renombrar_restricción_pg("msip_tcentropoblado", "msip_tclase_pkey", 
                               "msip_tcentropoblado_pkey")
    end

    rename_table :msip_clase_histvigencia, :msip_centropoblado_histvigencia

    rename_column :msip_centropoblado, :tclase_id, :tcentropoblado_id
    rename_column :msip_centropoblado, :clalocal_cod, :cplocal_cod
    if existe_restricción_pg?("clase_check")
      renombrar_restricción_pg("msip_centropoblado", "clase_check", "msip_centropoblado_check")
    end
    if existe_restricción_pg?("tclase_check")
      renombrar_restricción_pg("msip_tcentropoblado", "tclase_check", "msip_tcentropoblado_check")
    end

    if existe_restricción_pg?("clase_id_municipio_fkey")
      renombrar_restricción_pg("msip_centropoblado", "clase_id_municipio_fkey", "msip_centropoblado_id_municipio_fkey")
    end
    if existe_restricción_pg?("clase_id_tclase_fkey")
      renombrar_restricción_pg("msip_centropoblado", "clase_id_tclase_fkey", "msip_centropoblado_id_tcentropoblado_fkey")
    end
    
    if existe_restricción_pg?("msip_clase_id_municipio_id_clalocal_key")
      renombrar_restricción_pg(
        "msip_centropoblado", "msip_clase_id_municipio_id_clalocal_key", 
        "msip_centropoblado_id_municipio_id_cplocal_key"
      );
    end

    rename_column :msip_ubicacionpre, :clase_id, :centropoblado_id
    rename_column :msip_persona, :clase_id, :centropoblado_id
    rename_column :msip_ubicacion, :clase_id, :centropoblado_id

    rename_column :msip_centropoblado_histvigencia,
      :clase_id, :centropoblado_id
    rename_column :msip_centropoblado_histvigencia,
      :tclase_id, :tcentropoblado_id
    rename_column :msip_centropoblado_histvigencia,
      :clalocal_cod, :cplocal_cod

    if existe_restricción_pg?("persona_id_clase_fkey")
      renombrar_restricción_pg(
        "msip_persona", "persona_id_clase_fkey", 
        "msip_persona_centropoblado_id_fkey"
      );
    end
    if existe_restricción_pg?("ubicacion_id_clase_fkey")
      renombrar_restricción_pg(
        "msip_ubicacion", "ubicacion_id_clase_fkey", 
        "msip_ubicacion_centropoblado_id_fkey"
      );
    end



  end
  def down
    rename_column :msip_centropoblado_histvigencia,
      :cplocal_cod, :clalocal_cod
    rename_column :msip_centropoblado_histvigencia,
      :tcentropoblado_id, :tclase_id
    rename_column :msip_centropoblado_histvigencia,
      :centropoblado_id, :clase_id

    rename_column :msip_ubicacion, :centropoblado_id, :clase_id
    rename_column :msip_persona, :centropoblado_id, :clase_id
    rename_column :msip_ubicacionpre, :centropoblado_id, :clase_id

    rename_column :msip_centropoblado,  :cplocal_cod, :clalocal_cod
    rename_column :msip_centropoblado, :tcentropoblado_id, :tclase_id

    rename_table :msip_centropoblado_histvigencia, :msip_clase_histvigencia
    rename_table :msip_centropoblado, :msip_clase
    rename_table :msip_tcentropoblado, :msip_tclase
  end
end
