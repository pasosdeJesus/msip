# frozen_string_literal: true

require "msip/concerns/models/sectororgsocial"

module Msip
  # Sectores de las organizaciones sociales
  class Sectororgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::Sectororgsocial
  end
end
