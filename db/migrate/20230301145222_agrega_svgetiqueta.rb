class AgregaSvgetiqueta < ActiveRecord::Migration[7.0]
  def change
    add_column :msip_pais, :svgrotx, :float
    add_column :msip_pais, :svgroty, :float
    add_column :msip_departamento, :svgrotx, :float
    add_column :msip_departamento, :svgroty, :float
    add_column :msip_municipio, :svgrotx, :float
    add_column :msip_municipio, :svgroty, :float
    add_column :msip_clase, :svgrotx, :float
    add_column :msip_clase, :svgroty, :float
  end
end
