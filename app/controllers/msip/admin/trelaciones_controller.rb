# frozen_string_literal: true

require "msip/concerns/controllers/trelaciones_controller"

module Msip
  module Admin
    # Controlador de tipos de relación.
    class TrelacionesController < BasicasController
      before_action :set_trelacion, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Trelacion

      include Msip::Concerns::Controllers::TrelacionesController
    end
  end
end
