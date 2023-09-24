# frozen_string_literal: true

require "msip/concerns/controllers/etiquetas_controller"

module Msip
  module Admin
    class EtiquetasController < BasicasController

      before_action :set_etiqueta, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Etiqueta

      include Msip::Concerns::Controllers::EtiquetasController
    end
  end
end
