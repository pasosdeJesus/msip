
require 'msip/concerns/models/bitacora'

module Msip
  class Bitacora < ActiveRecord::Base
    include Msip::Concerns::Models::Bitacora
  end
end
