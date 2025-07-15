# frozen_string_literal: true

# Asegurese de reiniciar su  servidor tras modificar este archivo.

if !Rails || !Rails.application || !Rails.application.config || !Rails.application.config.respond_to?(:assets)
  return
end

# if defined?(Rails.application.config.assets)
# Versión de sus recursos, cambie esto si quiere que todos sus recursos expiren
Rails.application.config.assets.version = "1.0"

# Agregue más rutas a la ruta para cargar recursos
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.paths << Rails.root.join("node_modules/")


