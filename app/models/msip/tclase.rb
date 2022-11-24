# frozen_string_literal: true

require "msip/concerns/models/tclase"

module Msip
  class Tclase < ActiveRecord::Base
    include Msip::Concerns::Models::Tclase
  end
end
