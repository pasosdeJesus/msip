# frozen_string_literal: true

require "msip/concerns/models/clase"

module Msip
  class Clase < ActiveRecord::Base
    include Msip::Concerns::Models::Clase
  end
end
