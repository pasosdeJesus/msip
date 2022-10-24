
require 'msip/concerns/models/orgsocial_persona'

module Msip
  class OrgsocialPersona < ActiveRecord::Base
    include Msip::Concerns::Models::OrgsocialPersona
  end
end
