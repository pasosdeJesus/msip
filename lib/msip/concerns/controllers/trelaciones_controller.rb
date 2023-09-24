# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
    module TrelacionesController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

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

        end # included
      end
    end
  end
end
