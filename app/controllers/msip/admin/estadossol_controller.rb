# frozen_string_literal: true

require "msip/concerns/controllers/estadossol_controller"

module Msip
  module Admin
    # Controlador de estados de solicitud.
    class EstadossolController < Msip::Admin::BasicasController
      before_action :set_estadosol,
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Estadosol

      include Msip::Concerns::Controllers::EstadossolController
    end
  end
end
