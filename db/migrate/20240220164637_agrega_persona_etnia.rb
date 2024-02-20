class AgregaPersonaEtnia < ActiveRecord::Migration[7.1]
  def up
    add_column :msip_persona, :etnia_id, :integer, null: false, default: 1
    add_foreign_key :msip_persona, :msip_etnia, column: :etnia_id
  end
  def down
    remove_column :msip_persona, :etnia_id, :integer
  end
end
