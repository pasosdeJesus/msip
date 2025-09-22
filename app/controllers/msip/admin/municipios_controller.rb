# frozen_string_literal: true

require "msip/concerns/controllers/municipios_controller"

module Msip
  module Admin
    # Controlador de municipios.
    class MunicipiosController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::MunicipiosController
    end
  end
end
