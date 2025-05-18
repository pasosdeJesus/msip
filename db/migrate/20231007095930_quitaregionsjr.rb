# frozen_string_literal: true

class Quitaregionsjr < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper

  def up
    if Usuario.column_names.include?("regionsjr_id")
      remove_column(:usuario, :regionsjr_id)
    end
    if existe_restricción_pg?("regionsjr_check")
      renombrar_restricción_pg(
        "msip_oficina",
        "regionsjr_check",
        "msip_oficina_fechadeshabilitacion_chequeo",
      )
    end
    if existe_restricción_pg?("oficina_pkey")
      renombrar_restricción_pg(
        "msip_oficina",
        "oficina_pkey",
        "msip_oficina_pkey",
      )
    end
  end

  def down
  end
end
