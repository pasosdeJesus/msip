# frozen_string_literal: true

require "msip/concerns/models/fuenteprensa"

module Msip
  class Fuenteprensa < ActiveRecord::Base
    include Msip::Concerns::Models::Fuenteprensa
  end
end
