# frozen_string_literal: true

require "msip/concerns/models/municipio_histvigencia"

module Msip
  # Historial de vigencia de municipios deshabilitados
  class MunicipioHistvigencia < ActiveRecord::Base
    include Msip::Concerns::Models::MunicipioHistvigencia
  end
end
