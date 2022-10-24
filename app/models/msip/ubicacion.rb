
require 'msip/concerns/models/ubicacion'

module Msip
  class Ubicacion < ActiveRecord::Base
    include Msip::Concerns::Models::Ubicacion
  end
end
