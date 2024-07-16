# frozen_string_literal: true

require "msip/concerns/models/trelacion"

module Msip
  # Tipo de relación entre dos personas (tipicamente familiares)
  class Trelacion < ActiveRecord::Base
    include Msip::Concerns::Models::Trelacion
  end
end
