require "msip/concerns/models/sectororgsocial"

module Msip
  class Sectororgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::Sectororgsocial
  end
end
