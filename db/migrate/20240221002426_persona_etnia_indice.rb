class PersonaEtniaIndice < ActiveRecord::Migration[7.1]
  def change
    add_index :msip_persona, :etnia_id
  end
end
