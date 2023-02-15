# frozen_string_literal: true

# punto de montaje de la aplicación
Rails.application.config.relative_url_root = 
  ENV.fetch("RUTA_RELATIVA", "/")

if defined?(Rails.application.config.assets)
  # punto de montaje de los recursos
  Rails.application.config.assets.prefix = 
    ENV.fetch("RUTA_RELATIVA", "/") == "/" ? "/assets" : 
    (ENV.fetch("RUTA_RELATIVA", "/") + "/assets")
end
