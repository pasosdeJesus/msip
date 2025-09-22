# frozen_string_literal: true

# == Refresco de Vistas Materializadas
#
# Este archivo configura el refresco de vistas materializadas al inicio de la aplicación.
# Asegúrese de reiniciar su servidor tras modificar este archivo.

Rails.application.reloader.to_prepare do
  Msip::Mundep.refresca
end
