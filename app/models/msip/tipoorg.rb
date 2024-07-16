# frozen_string_literal: true

require "msip/concerns/models/tipoorg"

module Msip
  # Tipo de organización
  class Tipoorg < ActiveRecord::Base
    include Msip::Concerns::Models::Tipoorg
  end
end
