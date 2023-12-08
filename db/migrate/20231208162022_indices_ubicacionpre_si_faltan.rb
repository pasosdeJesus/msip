class IndicesUbicacionpreSiFaltan < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper
  def up
    if !existe_índice_pg?("msip_ubicacionpre_pais_id_idx")
      add_index :msip_ubicacionpre, :pais_id,
        name: "msip_ubicacionpre_pais_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_departamento_id_idx")
      add_index :msip_ubicacionpre, :departamento_id,
        name: "msip_ubicacionpre_departamento_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_municipio_id_idx")
      add_index :msip_ubicacionpre, :municipio_id,
        name: "msip_ubicacionpre_municipio_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_centropoblado_id_idx")
      add_index :msip_ubicacionpre, :centropoblado_id,
        name: "msip_ubicacionpre_centropoblado_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_vereda_id_idx")
      add_index :msip_ubicacionpre, :vereda_id,
        name: "msip_ubicacionpre_vereda_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_tsitio_id_idx")
      add_index :msip_ubicacionpre, :vereda_id,
        name: "msip_ubicacionpre_tsitio_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_pais_id_departamento_id_idx")
      add_index :msip_ubicacionpre, [:pais_id, :departamento_id],
        name: "msip_ubicacionpre_pais_id_departamento_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_departamento_id_municipio_id_idx")
      add_index :msip_ubicacionpre, [:departamento_id, :municipio_id],
        name: "msip_ubicacionpre_departamento_id_municipio_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_municipio_id_centropoblado_id_idx")
      add_index :msip_ubicacionpre, [:municipio_id, :centropoblado_id],
        name: "msip_ubicacionpre_municipio_id_centropoblado_id_idx"
    end
    if !existe_índice_pg?("msip_ubicacionpre_municipio_id_vereda_id_idx")
      add_index :msip_ubicacionpre, [:municipio_id, :vereda_id],
        name: "msip_ubicacionpre_municipio_id_vereda_id_idx"
    end
  end
  def down
  end
end
