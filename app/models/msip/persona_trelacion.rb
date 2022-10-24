
require 'msip/concerns/models/persona_trelacion'

module Msip
  class PersonaTrelacion < ActiveRecord::Base
    include Msip::Concerns::Models::PersonaTrelacion
  end
end
