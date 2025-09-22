# frozen_string_literal: true

# == Configuración de Filtrado de Parámetros
#
# Este archivo configura los parámetros sensibles que serán filtrados de los archivos de log.
# Asegúrese de reiniciar su servidor tras modificar este archivo.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password]
