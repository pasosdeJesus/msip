# frozen_string_literal: true

class MejoraTrelacion < ActiveRecord::Migration[7.0]
  def up
    execute(<<-SQL)
      UPDATE msip_trelacion SET nombre='MADRASTRA/PADRASTRO'
        WHERE id = 'PD';
      UPDATE msip_trelacion SET inverso='SI'
        WHERE id = 'SI';
    SQL
  end

  def down
    execute(<<-SQL)
      UPDATE msip_trelacion SET nombre='MADRASTRA (PADRASTRO)'
        WHERE id = 'PD';
      UPDATE msip_trelacion SET inverso=NULL
        WHERE id = 'SI';
    SQL
  end
end
