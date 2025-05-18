# frozen_string_literal: true

require "msip/concerns/controllers/ubicacionespre_controller"

module Msip
  module Admin
    class UbicacionespreController < Msip::Admin::BasicasController
      before_action :set_ubicacionpre,
        only: [:show, :edit, :update, :destroy],
        except: [:validar_conjunto]
      load_and_authorize_resource class: Msip::Ubicacionpre

      include Msip::Concerns::Controllers::UbicacionespreController
    end
  end
end
