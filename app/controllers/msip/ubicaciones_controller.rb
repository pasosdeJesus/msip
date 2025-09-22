# frozen_string_literal: true

require "msip/concerns/controllers/ubicaciones_controller"

module Msip
  # Controlador de ubicaciones geográficas.
  class UbicacionesController < ApplicationController
    load_and_authorize_resource class: Msip::Ubicacion

    include Msip::Concerns::Controllers::UbicacionesController
  end
end
