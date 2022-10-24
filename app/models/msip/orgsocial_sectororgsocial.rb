
require 'msip/concerns/models/orgsocial_sectororgsocial'

module Msip
  class OrgsocialSectororgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::OrgsocialSectororgsocial
  end
end
