# frozen_string_literal: true

require "msip/concerns/models/anexo"

module Msip
  # Archivo adjuntando a algun otro elemento. En el momento se almacena en el
  # directorio del servidor definido en la variabe de ambiente `RUTA_ANEXOS`
  class Anexo < ActiveRecord::Base
    include Msip::Concerns::Models::Anexo
  end
end
