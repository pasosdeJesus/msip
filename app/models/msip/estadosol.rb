# frozen_string_literal: true

require "msip/concerns/models/estadosol"

module Msip
  # Estado de una solicitud, e.g PENDIENTE, RESUELTA
  class Estadosol < ActiveRecord::Base
    include Msip::Concerns::Models::Estadosol
  end
end
