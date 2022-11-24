# frozen_string_literal: true

require "msip/concerns/controllers/solicitudes_controller"

module Msip
  class SolicitudesController < Msip::ModelosController
    before_action :set_solicitud, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Msip::Solicitud

    include Msip::Concerns::Controllers::SolicitudesController
  end
end
