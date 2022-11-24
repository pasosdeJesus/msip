# frozen_string_literal: true

require "msip/concerns/models/ubicacionpre"

module Msip
  class Ubicacionpre < ActiveRecord::Base
    include Msip::Concerns::Models::Ubicacionpre
  end
end
