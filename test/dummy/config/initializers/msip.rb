# frozen_string_literal: true

require "msip/version"

Msip.setup do |config|
  config.ruta_anexos = ENV.fetch(
    "MSIP_RUTA_ANEXOS",
    Rails.root.join("/archivos/anexos"),
  )
  config.ruta_volcados = ENV.fetch(
    "MSIP_RUTA_VOLCADOS",
    Rails.root.join("/archivos/bd"),
  )
  config.titulo = "msip #{Msip::VERSION}"
  config.longitud_nusuario = 10
end
