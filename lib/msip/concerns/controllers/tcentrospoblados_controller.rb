# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module TcentrospobladosController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Tcentropoblado"
          end

          def set_tcentropoblado
            @basica = Tcentropoblado.find(params[:id])
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

          def tcentropoblado_params
            params.require(:tcentropoblado).permit(*atributos_form)
          end

        end
      end
    end
  end
end


