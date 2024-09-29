# frozen_string_literal: true

require "msip/concerns/models/perfilorgsocial"

module Msip
  # Perfil de una persona en una organización social
  class Perfilorgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::Perfilorgsocial
  end
end
