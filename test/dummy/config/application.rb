# frozen_string_literal: true

if ENV.fetch("RAILS_ENV", "development") == "test"
  require "simplecov" # Usará configuración de .simplecov
end

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
#require "action_cable/engine"
require "rails/test_unit/railtie"

# Requiere gemas listas en el Gemfile, incluyendo las
# limitadas a :test, :development, o :production.
Bundler.require(*Rails.groups)

require "msip"

module Dummy
  class Application < Rails::Application
    config.load_defaults(7.0)

    config.action_view.automatically_disable_submit_tag = false

    # Las configuraciones en config/environments/* tiene precedencia sobre
    # las especificadas aquí.
    # La configuración de la aplicación puede ir en archivos en
    # config/initializers
    # -- todos los archivos .rb en ese directorio se cargan automáticamente
    # tras cargar el entorno y cualquier gema en su aplicación.

    config.autoload_lib(ignore: %w(assets tasks))

    # Establece Time.zone por defecto en la zona especificada y hace que
    # Active Record auto-convierta a esta zona.
    # Ejecute "rake -D time" para ver una lista de tareas para encontrar
    # nombres de zonas. Por omisión es UTC.
    config.time_zone = "America/Bogota"

    # El locale predeterminado es :en y todas las traducciones de
    # config/locales/*.rb,yml se cargan automaticamente
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    config.railties_order = [:main_app, Msip::Engine, :all]

    config.colorize_logging = true

    config.active_record.schema_format = :sql

    puts "CONFIG_HOSTS=" + ENV.fetch("CONFIG_HOSTS", "defensor.info").to_s
    config.hosts.concat(
      ENV.fetch("CONFIG_HOSTS", "defensor.info").downcase.split(";"),
    )

    config.relative_url_root = ENV.fetch('RUTA_RELATIVA', '/msip')

    # msip
    config.x.formato_fecha = ENV.fetch("MSIP_FORMATO_FECHA", "dd/M/yyyy")
    # En el momento soporta 3 formatos: yyyy-mm-dd, dd-mm-yyyy y dd/M/yyyy
  end
end
