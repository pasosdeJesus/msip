# frozen_string_literal: true

require "msip/concerns/controllers/fuentesprensa_controller"

module Msip
  module Admin
    # Controlador de fuentes de prensa.
    class FuentesprensaController < Msip::Admin::BasicasController
      before_action :set_fuenteprensa,
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Fuenteprensa

      include Msip::Concerns::Controllers::FuentesprensaController
    end
  end
end
