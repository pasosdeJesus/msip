require 'msip/concerns/controllers/ubicacionespre_controller'

module Msip
  class UbicacionespreController < Msip::ModelosController

    before_action :set_ubicacionpre, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: Msip::Ubicacionpre

    include Msip::Concerns::Controllers::UbicacionespreController

  end
end
