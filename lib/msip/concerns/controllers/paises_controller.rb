# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module PaisesController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Pais"
          end

          def set_pais
            @basica = Pais.find(params[:id])
          end

          def atributos_index_msip
            [
              :id,
              :nombre,
              :nombreiso_espanol,
              :latitud_localizado,
              :longitud_localizado,
              :alfa2,
              :alfa3,
              :codiso,
              :nombreiso_ingles,
              :nombreiso_frances,
              :div1,
              :div2,
              :div3,
              :observaciones,
              :ultvigenciaini,
              :ultvigenciafin,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def atributos_index
            atributos_index_msip
          end

          def atributos_show_msip
            atributos_transf_habilitado +
              [:svgcdx, :svgcdy, :svgcdancho, :svgcdalto, :svgruta]
          end

          def atributos_show
            atributos_show_msip
          end

          def atributos_form
            atributos_transf_habilitado
          end

          def genclase
            "M"
          end

          def pais_params
            params.require(:pais).permit(*atributos_form)
          end
        end # included
      end
    end
  end
end
