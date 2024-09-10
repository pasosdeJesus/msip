# frozen_string_literal: true

require "msip/concerns/models/orgsocial_sectororgsocial"

module Msip
  # Relación n:n entre organización social y sector de organización social
  class OrgsocialSectororgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::OrgsocialSectororgsocial
  end
end
