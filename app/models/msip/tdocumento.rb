# frozen_string_literal: true

require "msip/concerns/models/tdocumento"

module Msip
  class Tdocumento < ActiveRecord::Base
    include Msip::Concerns::Models::Tdocumento
  end
end
