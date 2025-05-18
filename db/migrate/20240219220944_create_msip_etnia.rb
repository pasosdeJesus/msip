# frozen_string_literal: true

class CreateMsipEtnia < ActiveRecord::Migration[7.1]
  include Msip::SqlHelper

  def up
    create_table(:msip_etnia) do |t|
      t.string(:nombre, limit: 500, null: false)
      t.string(:descripcion, limit: 1000)
      t.string(:observaciones, limit: 5000)
      t.date(:fechacreacion, null: false)
      t.date(:fechadeshabilitacion)

      t.timestamps
    end
    cambiaCotejacion("msip_etnia", "nombre", 500, "es_co_utf_8")
    execute(<<-SQL)
      ALTER TABLE msip_etnia ADD CONSTRAINT etnia_check#{" "}
        CHECK (((fechadeshabilitacion IS NULL) OR#{" "}
          (fechadeshabilitacion >= fechacreacion)));
    SQL
  end

  def down
    drop_table(:msip_etnia)
  end
end
