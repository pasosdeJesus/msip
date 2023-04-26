# frozen_string_literal: true

require "msip/concerns/models/etiqueta_persona"

module Msip
  class EtiquetaPersona < ActiveRecord::Base
    include Msip::Concerns::Models::EtiquetaPersona
  end
end
