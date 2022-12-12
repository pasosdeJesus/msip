# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module DepartamentosController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Departamento"
          end

          def index
            c = nil
            if params[:id_pais] && params[:id_pais] != ""
              idpais = params[:id_pais].to_i
              c = Msip::Departamento.where(fechadeshabilitacion: nil,
                id_pais: idpais).all
            end
            super(c)
          end

          def set_departamento
            @basica = Departamento.find(params[:id])
          end

          def atributos_index
            [
              :id,
              :nombre,
              :id_pais,
              :id_deplocal,
              :codreg,
              :latitud,
              :longitud,
              :observaciones,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def atributos_show
            atributos_transf_habilitado + 
              [:svgcdx, :svgcdy, :svgcdancho, :svgcdalto, :svgruta]
          end

          def genclase
            "M"
          end

          def departamento_params
            params.require(:departamento).permit(*atributos_form)
          end
        end # included
      end
    end
  end
end
