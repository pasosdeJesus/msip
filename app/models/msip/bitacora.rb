# frozen_string_literal: true

require "msip/concerns/models/bitacora"

module Msip
  # Registra un evento (adición, eliminación, etc.) junto con quien lo hizo y
  # detalles para analizar y/o depurar
  class Bitacora < ActiveRecord::Base
    include Msip::Concerns::Models::Bitacora
  end
end
