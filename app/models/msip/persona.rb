# frozen_string_literal: true

require "msip/concerns/models/persona"

module Msip
  # Datos de una persona
  class Persona < ActiveRecord::Base
    include Msip::Concerns::Models::Persona
  end
end
