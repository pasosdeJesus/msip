# frozen_string_literal: true

require "msip/concerns/controllers/tiposorg_controller"

module Msip
  module Admin
    # Controlador de tipos de organización.
    class TiposorgController < BasicasController
      before_action :set_tipoorg, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tipoorg

      include Msip::Concerns::Controllers::TiposorgController
    end
  end
end
