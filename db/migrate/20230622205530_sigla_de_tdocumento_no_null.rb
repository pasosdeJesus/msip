class SiglaDeTdocumentoNoNull < ActiveRecord::Migration[7.0]
  def up
    change_column :msip_tdocumento, :sigla, :string, limit: 500, null: false
  end
  def down
    change_column :msip_tdocumento, :sigla, :string, limit: 500, null: true
  end
end
