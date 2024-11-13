# frozen_string_literal: true

# frozenn_string_literal: true

module Msip
  module Concerns
    module Controllers
      module VeredasController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Vereda"
          end

          def index
            c = nil
            if params[:municipio_id]
              idmun = params[:municipio_id].to_i > 0 ? 
                params[:municipio_id].to_i : nil
              c = Msip::Vereda.where(
                fechadeshabilitacion: nil,
                municipio_id: idmun,
              ).all
            end
            Msip::Municipio.conf_presenta_nombre_con_departamento = true
            super(c)
          end

          def set_vereda
            @basica = Vereda.find(params[:id])
          end

          def atributos_index
            [
              :id,
              :nombre,
              :pais,
              :departamento,
              :municipio_id, # belongs_to
              :verlocal_cod,
              :latitud,
              :longitud,
              :observaciones,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def atributos_form
            Msip::Municipio.conf_presenta_nombre_con_origen = true
            atributos_transf_habilitado - [
              :id, 
              "id", 
              :pais, 
              "pais,", 
              :departamento, 
              "departamento",
              "fechacreacion_localizada",
              :fechacreacion_localizada,
            ]  + [
              :fechacreacion
            ]
          end

          def genclase
            "F"
          end

          def vereda_params
            params.require(:vereda).permit(*atributos_form)
          end
        end
      end
    end
  end
end
