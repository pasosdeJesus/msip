# frozen_string_literal: true

require "msip/concerns/models/etiqueta_municipio"

module Msip
  # Relación n:n entre etiqueta y municipio
  class EtiquetaMunicipio < ActiveRecord::Base
    include Msip::Concerns::Models::EtiquetaMunicipio
  end
end
