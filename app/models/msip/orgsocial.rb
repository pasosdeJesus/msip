require 'msip/concerns/models/orgsocial'

module Msip
  class Orgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::Orgsocial
  end
end
