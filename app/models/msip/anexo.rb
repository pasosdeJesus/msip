# frozen_string_literal: true

require "msip/concerns/models/anexo"

module Msip
  # Archivo adjuntando a algún otro elemento. El archivo se almacena en el
  # directorio del servidor definido en la variable de ambiente
  # `MSIP_RUTA_ANEXOS`
  class Anexo < ActiveRecord::Base
    include Msip::Concerns::Models::Anexo
  end
end
