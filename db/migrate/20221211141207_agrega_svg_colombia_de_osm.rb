# frozen_string_literal: true

class AgregaSvgColombiaDeOsm < ActiveRecord::Migration[7.0]
  # Agrega silueta de Colombia obtenida de OpenStreetMap
  # Se agrega en SVG junto con cuadro delimitador, tras transformarla
  # con mapshaper de GeoJSON obtenido de osm-boundaries.com

  def up
    # Pais
    execute(<<~SQL.squish)
    SQL
  end

  def down
    execute(<<~SQL.squish)
      UPDATE msip_pais SET svgruta=NULL, svgcdx=NULL, svgcdy=NULL,
        svgcdancho=NULL, svgcdalto=NULL WHERE svgruta IS NOT NULL;
    SQL
  end
end