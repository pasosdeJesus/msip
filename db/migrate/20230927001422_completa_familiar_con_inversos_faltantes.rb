class CompletaFamiliarConInversosFaltantes < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      INSERT INTO msip_persona_trelacion (persona1, persona2, trelacion_id)
      (SELECT persona2, persona1, tr.inverso 
        FROM msip_persona_trelacion AS pt 
        JOIN msip_trelacion AS tr ON tr.id=pt.trelacion_id 
        WHERE (pt.persona2, pt.persona1) NOT IN 
        (SELECT persona1, persona2 FROM msip_persona_trelacion)
      )
    SQL
  end
  def down
    raise IrreversibleMigration
  end
end
