# frozen_string_literal: true

require "msip/concerns/models/tsitio"

module Msip
  # Tipo de sitio, (e.g rural, urbano)
  class Tsitio < ActiveRecord::Base
    include Msip::Concerns::Models::Tsitio
  end
end
