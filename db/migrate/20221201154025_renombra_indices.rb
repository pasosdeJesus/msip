# frozen_string_literal: true

class RenombraIndices < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper

  IND = [
    ["sip_busca_mundep", "msip_busca_mundep"],
    ["sip_nombre_ubicacionpre_b", "msip_nombre_ubicacionpre_b"],
    ["sip_persona_anionac_ind", "msip_persona_anionac_ind"],
    ["sip_persona_sexo_ind", "msip_persona_sexo_ind"],
    ["trelacion_pkey", "msip_trelacion_pkey"],
    ["tclase_pkey", "msip_tclase_pkey"],
  ]

  def up
    IND.each do |i|
      if existe_índice_pg?(i[0])
        renombrar_índice_pg(i[0], i[1])
      end
    end
  end

  def down
    IND.reverse.each do |i|
      if existe_índice_pg?(i[1])
        renombrar_índice_pg(i[1], i[0])
      end
    end
  end
end
