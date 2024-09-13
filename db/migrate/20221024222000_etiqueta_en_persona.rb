class EtiquetaEnPersona < ActiveRecord::Migration[7.0]
  def up
    if !table_exists?(:msip_etiqueta_persona)
      create_table :msip_etiqueta_persona do |t|
        t.integer :etiqueta_id, null: false
        t.integer :persona_id, null: false
        t.integer :usuario_id, null: false
        t.date :fecha, null: false
        t.string :observaciones, limit: 5000
        t.timestamps
      end
      add_foreign_key :msip_etiqueta_persona, :msip_etiqueta, column: :etiqueta_id
      add_foreign_key :msip_etiqueta_persona, :msip_persona, column: :persona_id
      add_foreign_key :msip_etiqueta_persona, :usuario, column: :usuario_id
    end
  end
  def down
    drop_table :msip_etiqueta_persona
  end
end
