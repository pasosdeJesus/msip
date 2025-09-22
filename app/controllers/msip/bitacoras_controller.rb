# frozen_string_literal: true

require "msip/concerns/controllers/bitacoras_controller"

module Msip
  # Controlador de bitácoras.
  class BitacorasController < Msip::ModelosController
    before_action :set_bitacora,
      only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Msip::Bitacora

    include Msip::Concerns::Controllers::BitacorasController
  end
end
