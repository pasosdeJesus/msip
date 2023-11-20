# frozen_string_literal: true

require "msip/concerns/models/centropoblado"

module Msip
  class Centropoblado < ActiveRecord::Base
    include Msip::Concerns::Models::Centropoblado
  end
end
