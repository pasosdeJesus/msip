class ArreglaSipi < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE msip_municipio SET
      nombre='Sipí' WHERE id=1207;
    SQL
  end
  def down
    execute <<-SQL
      UPDATE msip_municipio SET
      nombre='Msipí' WHERE id=1207;
    SQL
  end
end
