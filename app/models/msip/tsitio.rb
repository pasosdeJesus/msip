# frozen_string_literal: true

require "msip/concerns/models/tsitio"

module Msip
  class Tsitio < ActiveRecord::Base
    include Msip::Concerns::Models::Tsitio
  end
end
