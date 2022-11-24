require "msip/concerns/models/trelacion"

module Msip
  class Trelacion < ActiveRecord::Base
    include Msip::Concerns::Models::Trelacion
  end
end
