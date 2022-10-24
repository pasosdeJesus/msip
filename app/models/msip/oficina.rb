
require 'msip/concerns/models/oficina'

module Msip
  class Oficina < ActiveRecord::Base
    include Msip::Concerns::Models::Oficina
  end
end
