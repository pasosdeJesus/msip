# frozen_string_literal: true

# == Configuración del Punto de Montaje
#
# Este archivo configura el punto de montaje de la aplicación y de los assets.
# Asegúrese de reiniciar su servidor tras modificar este archivo.

# punto de montaje de la aplicación
Rails.application.config.relative_url_root =
  ENV.fetch("RUTA_RELATIVA", "/")

if defined?(Rails.application.config.assets)
  # punto de montaje de los recursos
  Rails.application.config.assets.prefix =
    if ENV.fetch("RUTA_RELATIVA", "/") == "/"
      "/assets"
    else
      (ENV.fetch("RUTA_RELATIVA", "/") + "/assets")
    end
end
