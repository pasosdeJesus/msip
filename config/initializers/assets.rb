# frozen_string_literal: true

# == Configuración de Assets
#
# Este archivo configura el pipeline de assets de la aplicación.
# Asegúrese de reiniciar su servidor tras modificar este archivo.

if !Rails || !Rails.application || !Rails.application.config || !Rails.application.config.respond_to?(:assets)
  return
end

# if defined?(Rails.application.config.assets)
# Versión de sus recursos, cambie esto si quiere que todos sus recursos expiren
Rails.application.config.assets.version = "1.0"

# Agregue más rutas a la ruta para cargar recursos
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.paths << Rails.root.join("node_modules")

Rails.application.config.assets.paths << Rails.root.join("node_modules/@fortawesome/fontawesome-free/")
Rails.application.config.assets.paths << Rails.root.join("node_modules/tom-select/")

# Precompilar recursos adicionales.
# application.js, application.css, y todo lo que no es JS/CSS
#   en la carpeta app/assets ya han sido agregados.
Rails.application.config.assets.precompile += [
  "webfonts/fa-solid-900.eot",
  "webfonts/fa-solid-900.svg",
  "webfonts/fa-solid-900.ttf",
  "tom-select.bootrap5.min.css.map",
]
# end
