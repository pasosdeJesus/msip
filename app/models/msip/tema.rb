# frozen_string_literal: true

require "msip/concerns/models/tema"

module Msip
  # Tema para la interfaz del sistema de información. Actualmente colores de
  # varios elementos.
  class Tema < ActiveRecord::Base
    include Msip::Concerns::Models::Tema
  end
end
