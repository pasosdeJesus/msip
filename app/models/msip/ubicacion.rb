# frozen_string_literal: true

require "msip/concerns/models/ubicacion"

module Msip
  # Una ubicación geográfica enmarcada en una división política
  class Ubicacion < ActiveRecord::Base
    include Msip::Concerns::Models::Ubicacion
  end
end
