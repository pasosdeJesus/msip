class MejoraUbicacionpre < ActiveRecord::Migration[7.0]
  def up
    change_column :msip_ubicacionpre, :pais_id, :integer, null: false
    execute <<-SQL
      CREATE UNIQUE INDEX msip_departamento_pais_id_id_unico
        ON msip_departamento (pais_id, id);
      ALTER TABLE msip_departamento
        ADD CONSTRAINT msip_departamento_pais_id_id_unico
        UNIQUE USING INDEX msip_departamento_pais_id_id_unico;
      ALTER TABLE msip_ubicacionpre
          ADD CONSTRAINT fk_ubicacionpre_pais_departamento FOREIGN KEY (pais_id, departamento_id)
          REFERENCES msip_departamento (pais_id, id);

      CREATE UNIQUE INDEX msip_municipio_departamento_id_id_unico
        ON msip_municipio (departamento_id, id);
      ALTER TABLE msip_municipio
        ADD CONSTRAINT msip_municipio_departamento_id_id_unico
        UNIQUE USING INDEX msip_municipio_departamento_id_id_unico;
      ALTER TABLE msip_ubicacionpre
          ADD CONSTRAINT fk_ubicacionpre_departamento_municipio FOREIGN KEY (departamento_id, municipio_id)
          REFERENCES msip_municipio (departamento_id, id);

      CREATE UNIQUE INDEX msip_centropoblado_municipio_id_id_unico
        ON msip_centropoblado (municipio_id, id);
      ALTER TABLE msip_centropoblado
        ADD CONSTRAINT msip_centropoblado_municipio_id_id_unico
        UNIQUE USING INDEX msip_centropoblado_municipio_id_id_unico;
      ALTER TABLE msip_ubicacionpre
          ADD CONSTRAINT fk_ubicacionpre_municipio_centropoblado FOREIGN KEY (municipio_id, centropoblado_id)
          REFERENCES msip_centropoblado (municipio_id, id);

      CREATE UNIQUE INDEX msip_vereda_municipio_id_id_unico
        ON msip_vereda (municipio_id, id);
      ALTER TABLE msip_vereda
        ADD CONSTRAINT msip_vereda_municipio_id_id_unico
        UNIQUE USING INDEX msip_vereda_municipio_id_id_unico;
      ALTER TABLE msip_ubicacionpre
          ADD CONSTRAINT fk_ubicacionpre_municipio_vereda FOREIGN KEY (municipio_id, vereda_id)
          REFERENCES msip_vereda (municipio_id, id);
    SQL
    add_column :msip_ubicacionpre, :observaciones, :string, limit: 5000
    add_column :msip_ubicacionpre, :fechacreacion, :date
    add_column :msip_ubicacionpre, :fechadeshabilitacion, :date
    execute <<-SQL
      UPDATE msip_ubicacionpre SET fechacreacion='2023-12-06';
    SQL
    change_column :msip_ubicacionpre, :fechacreacion, :date, 
      default: 'NOW()', null: false  # No operó el default
    execute <<-SQL
      ALTER TABLE msip_ubicacionpre ALTER COLUMN fechacreacion 
        SET DEFAULT NOW();
    SQL
  end
  def down
    remove_column :msip_ubicacionpre, :fechadeshabilitacion, :date
    remove_column :msip_ubicacionpre, :fechacreacion, :date, default: 'NOW()', null: false
    remove_column :msip_ubicacionpre, :observaciones, :string, limit: 5000
    execute <<-SQL
      ALTER TABLE msip_ubicacionpre
          DROP CONSTRAINT fk_ubicacionpre_municipio_vereda;
      ALTER TABLE msip_vereda
        DROP CONSTRAINT msip_vereda_municipio_id_id_unico;
      ALTER TABLE msip_ubicacionpre
          DROP CONSTRAINT fk_ubicacionpre_municipio_centropoblado;
      ALTER TABLE msip_centropoblado
        DROP CONSTRAINT msip_centropoblado_municipio_id_id_unico;
      ALTER TABLE msip_ubicacionpre
          DROP CONSTRAINT fk_ubicacionpre_departamento_municipio;
      ALTER TABLE msip_municipio
        DROP CONSTRAINT msip_municipio_departamento_id_id_unico;
      ALTER TABLE msip_ubicacionpre
          DROP CONSTRAINT fk_ubicacionpre_pais_departamento;
      ALTER TABLE msip_departamento
        DROP CONSTRAINT msip_departamento_pais_id_id_unico;
    SQL

  end
end
