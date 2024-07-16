# frozen_string_literal: true

require "msip/concerns/models/tdocumento"

module Msip
  # Tipo de documento de identidad (e.g Cédula, Pasaporte)
  class Tdocumento < ActiveRecord::Base
    include Msip::Concerns::Models::Tdocumento
  end
end
