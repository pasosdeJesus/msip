require "msip/concerns/models/perfilorgsocial"

module Msip
  class Perfilorgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::Perfilorgsocial
  end
end
