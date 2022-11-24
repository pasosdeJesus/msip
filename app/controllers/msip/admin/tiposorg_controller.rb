require "msip/concerns/controllers/tiposorg_controller"

module Msip
  module Admin
    class TiposorgController < BasicasController
      before_action :set_tipoorg, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tipoorg

      include Msip::Concerns::Controllers::TiposorgController
    end
  end
end
