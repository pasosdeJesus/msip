# frozen_string_literal: true

module Msip
  module Admin
    class TclasesController < BasicasController
      before_action :set_tclase, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tclase

      def clase
        "Msip::Tclase"
      end

      def set_tclase
        @basica = Tclase.find(params[:id])
      end

      def atributos_index
        [
          "id",
          "nombre",
          "observaciones",
          "fechacreacion_localizada",
          "habilitado",
        ]
      end

      def atributos_form
        atributos_show
      end

      def genclase
        "M"
      end

      def tclase_params
        params.require(:tclase).permit(*atributos_form)
      end
    end
  end
end
