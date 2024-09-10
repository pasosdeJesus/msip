# frozen_string_literal: true

require "msip/concerns/models/etiqueta_persona"

module Msip
  # Relación n:n entre etiqueta y persona
  class EtiquetaPersona < ActiveRecord::Base
    include Msip::Concerns::Models::EtiquetaPersona
  end
end
