require "msip/concerns/controllers/tdocumentos_controller"

module Msip
  module Admin
    class TdocumentosController < BasicasController
      before_action :set_tdocumento, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tdocumento

      include Msip::Concerns::Controllers::TdocumentosController
    end
  end
end
