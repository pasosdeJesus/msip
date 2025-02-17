# frozen_string_literal: true

class ReservaUbicacionpre < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      SELECT setval('msip_ubicacionpre_id_seq', 10000000);
    SQL
  end

  def down
  end
end
