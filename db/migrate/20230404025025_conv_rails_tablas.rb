class ConvRailsTablas < ActiveRecord::Migration[7.0]
  def change
    rename_column :msip_departamento, :id_pais, :pais_id
    rename_column :msip_departamento, :id_deplocal, :deplocal_cod

    rename_column :msip_departamento_histvigencia, :id_deplocal, :deplocal_cod

    rename_column :msip_municipio, :id_departamento, :departamento_id
    rename_column :msip_municipio, :id_munlocal, :munlocal_cod

    rename_column :msip_municipio_histvigencia, :id_munlocal, :munlocal_cod

    rename_column :msip_clase, :id_municipio, :municipio_id
    rename_column :msip_clase, :id_tclase, :tclase_id
    rename_column :msip_clase, :id_clalocal, :clalocal_cod

    rename_column :msip_clase_histvigencia, :id_clalocal, :clalocal_cod
    rename_column :msip_clase_histvigencia, :id_tclase, :tclase_id

    rename_column :msip_persona, :id_clase, :clase_id
    rename_column :msip_persona, :id_departamento, :departamento_id
    rename_column :msip_persona, :id_municipio, :municipio_id
    rename_column :msip_persona, :id_pais, :pais_id

    rename_column :msip_persona_trelacion, :id_trelacion, :trelacion_id

    rename_column :msip_ubicacion, :id_clase, :clase_id
    rename_column :msip_ubicacion, :id_municipio, :municipio_id
    rename_column :msip_ubicacion, :id_departamento, :departamento_id
    rename_column :msip_ubicacion, :id_pais, :pais_id
    rename_column :msip_ubicacion, :id_tsitio, :tsitio_id

  end
end
