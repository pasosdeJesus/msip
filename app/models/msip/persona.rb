
require 'msip/concerns/models/persona'

module Msip
  class Persona < ActiveRecord::Base
    include Msip::Concerns::Models::Persona
  end
end
