# frozen_string_literal: true

require "msip/concerns/models/fuenteprensa"

module Msip
  # Fuente de prensa. Listado inicial para Colombia de periodicos recientes.
  class Fuenteprensa < ActiveRecord::Base
    include Msip::Concerns::Models::Fuenteprensa
  end
end
