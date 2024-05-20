# frozen_string_literal: true

Dummy::Application.config.assets.prefix = ENV.fetch(
  "RUTA_RELATIVA", "msip"
) + "/assets"
