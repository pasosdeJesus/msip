# frozen_string_literal: true

require "msip/concerns/models/orgsocial_persona"

module Msip
  # Relación n:n entre persona y organización social
  class OrgsocialPersona < ActiveRecord::Base
    include Msip::Concerns::Models::OrgsocialPersona
  end
end
