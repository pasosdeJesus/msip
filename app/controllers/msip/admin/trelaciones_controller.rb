# frozen_string_literal: true

module Msip
  module Admin
    class TrelacionesController < BasicasController
      before_action :set_trelacion, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Trelacion

      def clase
        "Msip::Trelacion"
      end

      def set_trelacion
        @basica = Trelacion.find(params[:id])
      end

      def genclase
        "M"
      end

      def atributos_index
        [
          :id,
          :nombre,
          :inverso,
          :observaciones,
          :fechacreacion_localizada,
          :habilitado,
        ]
      end

      def atributos_form
        atributos_transf_habilitado
      end

      def trelacion_params
        params.require(:trelacion).permit(*atributos_form)
      end
    end
  end
end
