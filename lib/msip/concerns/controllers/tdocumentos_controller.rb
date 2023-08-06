# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module TdocumentosController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Tdocumento"
          end

          def set_tdocumento
            @basica = Tdocumento.find(params[:id])
          end

          def genclase
            "M"
          end

          def atributos_index
            [
              :id,
              :nombre,
              :sigla,
              :formatoregex,
              :observaciones,
              :ayuda,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def tdocumento_params
            params.require(:tdocumento).permit(*atributos_form)
          end
        end
      end
    end
  end
end
