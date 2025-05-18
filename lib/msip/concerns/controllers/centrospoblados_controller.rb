# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module CentrospobladosController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Centropoblado"
          end

          def index
            c = nil
            if params[:municipio_id]
              idmun = if params[:municipio_id].to_i > 0
                params[:municipio_id].to_i
              end
              c = Msip::Centropoblado.where(
                fechadeshabilitacion: nil,
                municipio_id: idmun,
              ).all
            end
            Msip::Municipio.conf_presenta_nombre_con_departamento = true
            super(c)
          end

          def set_centropoblado
            @basica = Centropoblado.find(params[:id])
          end

          def tipo_centropoblado
            id = params[:id].to_i
            if id > 0
              tcentropoblado_id = Msip::Centropoblado.find(id).tcentropoblado_id
              nombre_tipo = Msip::Tcentropoblado.find(tcentropoblado_id).nombre
              render(json: { nombre: nombre_tipo })
            else
              render(json: { nombre: "" })
            end
            nil
          end

          def atributos_index
            [
              :id,
              :nombre,
              :pais,
              :municipio_id,
              :cplocal_cod,
              :tcentropoblado_id,
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
              :fechacreacion_localizada,
              :pais,
              "pais",
            ] + [
              :fechacreacion,
            ]
          end

          def genclase
            "M"; # Centro poblado
          end

          def centropoblado_params
            params.require(:centropoblado).permit(*atributos_form)
          end
        end # included
      end
    end
  end
end
