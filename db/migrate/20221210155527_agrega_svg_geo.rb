class AgregaSvgGeo < ActiveRecord::Migration[7.0]
  def change
    [:msip_pais, :msip_departamento, :msip_municipio, :msip_clase].each do |t|
      add_column t, :svgruta, :string
      add_column t, :svgcdx, :integer # Cuadro delimitador x
      add_column t, :svgcdy, :integer # Cuadro delimitador y
      add_column t, :svgcdancho, :integer# Cuadro delimitador ancho
      add_column t, :svgcdalto, :integer # Cuadro delimitador alto
    end
  end
end
