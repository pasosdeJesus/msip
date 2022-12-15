# frozen_string_literal: true

class QuitaExterior < ActiveRecord::Migration[7.0]
  def up
    if Msip::Departamento.where(id: 3).where(nombre: "EXTERIOR").count == 1
      Msip::Municipio.where(id_departamento: 3).destroy_all
      e = Msip::Departamento.find(3)
      e.destroy
    end
  end
end
