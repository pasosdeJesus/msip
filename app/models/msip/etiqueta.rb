# frozen_string_literal: true

require "msip/concerns/models/etiqueta"

module Msip
  # Etiqueta que puede ponerse a algún elemento por ejemplo para análisis
  # de un conjnto de datos o para alertar
  class Etiqueta < ActiveRecord::Base
    include Msip::Concerns::Models::Etiqueta
  end
end
