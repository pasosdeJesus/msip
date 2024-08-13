# frozen_string_literal: true

require "msip/concerns/models/pais_histvigencia"

module Msip
  # Historial de vigencia de pais deshabilitados
  class PaisHistvigencia < ActiveRecord::Base
    include Msip::Concerns::Models::PaisHistvigencia
  end
end
