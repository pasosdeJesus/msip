# frozen_string_literal: true

require "msip/concerns/models/estadosol"

module Msip
  class Estadosol < ActiveRecord::Base
    include Msip::Concerns::Models::Estadosol
  end
end
