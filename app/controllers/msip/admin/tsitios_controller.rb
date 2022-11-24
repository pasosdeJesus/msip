# frozen_string_literal: true

module Msip
  module Admin
    class TsitiosController < BasicasController
      before_action :set_tsitio, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tsitio

      def clase
        "Msip::Tsitio"
      end

      def set_tsitio
        @basica = Tsitio.find(params[:id])
      end

      def genclase
        "M"
      end

      def tsitio_params
        params.require(:tsitio).permit(*atributos_form)
      end
    end
  end
end
