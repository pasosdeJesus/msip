# frozen_string_literal: true

require "msip/concerns/models/ubicacionpre"

module Msip
  # Una ubicación geográfica enmarcada en una división política pero sin
  # repetidos
  class Ubicacionpre < ActiveRecord::Base
    include Msip::Concerns::Models::Ubicacionpre
  end
end
