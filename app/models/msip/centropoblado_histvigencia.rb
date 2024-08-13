# frozen_string_literal: true

require "msip/concerns/models/centropoblado_histvigencia"

module Msip
  # Historial de vigencia de centros poblados deshabilitados
  class CentropobladoHistvigencia < ActiveRecord::Base
    include Msip::Concerns::Models::CentropobladoHistvigencia
  end
end
