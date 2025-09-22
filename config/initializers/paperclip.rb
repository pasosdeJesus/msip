# frozen_string_literal: true

# == Configuración de Paperclip
#
# Este archivo configura Paperclip para permitir la carga de archivos sin validación de tipo MIME.
# Esto es útil en entornos donde la detección de tipo MIME puede ser problemática o no es necesaria.

require "paperclip/media_type_spoof_detector"
module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
