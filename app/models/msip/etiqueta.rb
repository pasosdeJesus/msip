# frozen_string_literal: true

require "msip/concerns/models/etiqueta"

module Msip
  # Etiqueta que puede ponérsele a algún elemento por ejemplo para analizar
  # un conjunto de datos o para alertar
  class Etiqueta < ActiveRecord::Base
    include Msip::Concerns::Models::Etiqueta
  end
end
