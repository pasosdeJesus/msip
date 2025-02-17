# frozen_string_literal: true

class ArreglaSipi < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      UPDATE msip_municipio SET
      nombre='Sipí' WHERE id=1207;

      UPDATE msip_clase SET
      nombre='Sipirra' WHERE id=1652;
      UPDATE msip_clase SET
      nombre='Sipí' WHERE id=5448;
    SQL
  end

  def down
  end
end
