# frozen_string_literal: true

require "msip/concerns/controllers/tdocumentos_controller"

module Msip
  module Admin
    # Controlador de tipos de documento.
    class TdocumentosController < BasicasController
      before_action :set_tdocumento, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tdocumento

      include Msip::Concerns::Controllers::TdocumentosController
    end
  end
end
