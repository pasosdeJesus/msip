# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module MunicipiosController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Municipio"
          end

          def index
            c = nil
            if params[:departamento_id]
              iddep = params[:departamento_id].to_i > 0 ? 
                params[:departamento_id].to_i : nil
              c = Msip::Municipio.where(
                fechadeshabilitacion: nil,
                departamento_id: iddep,
              ).all
            end
            Msip::Departamento.conf_presenta_nombre_con_origen = false
            super(c)
          end

          def set_municipio
            @basica = Municipio.find(params[:id])
          end

          def atributos_index
            [
              :id,
              :nombre,
              :pais,
              :departamento_id,
              :munlocal_cod,
              :codreg,
              :tipomun,
              :latitud,
              :longitud,
              :observaciones,
              :etiqueta_ids,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def atributos_show
            l = atributos_transf_habilitado - [
              :fechadeshabilitacion,
              "fechadeshabilitacion"
            ]
           l += [
              :fechadeshabilitacion_localizada,
              :svgcdx,
              :svgcdy,
              :svgcdancho,
              :svgcdalto,
              :svgruta
            ]
           l
          end

          def atributos_form
            Msip::Departamento.conf_presenta_nombre_con_origen = true
            atributos_transf_habilitado -
              [
                :id,
                "id",
                :fechacreacion_localizada,
                :pais,
                "pais",
                :etiqueta_ids
              ] +
              [
                :fechacreacion,
                etiqueta_ids: [],
              ]
          end

          def genclase
            "M"
          end

          def municipio_params
            params.require(:municipio).permit(*atributos_form)
          end

          # Para responder a solicitudes AJAX de autocompletación de
          # municipio / departamento
          def mundep
            if !params[:term]
              respond_to do |format|
                format.html { render(inline: "Falta variable term") }
                format.json { render(inline: "Falta variable term") }
              end
            else
              term = Msip::Municipio.connection.quote_string(params[:term])
              consNom = term.downcase.strip # sin_tildes
              consNom.gsub!(/ +/, ":* & ")
              unless consNom.empty?
                consNom += ":*"
              end
              # autocomplete de jquery requiere label, val
              consc = ActiveRecord::Base.send(:sanitize_sql_array, [
                "SELECT nombre as label, idlocal as value
                FROM public.msip_mundep
                WHERE mundep  @@ to_tsquery('spanish', ?)
                ORDER BY 1 LIMIT 10;",
                consNom,
              ])
              r = ActiveRecord::Base.connection.select_all(consc)
              respond_to do |format|
                format.json { render(:json, inline: r.to_json) }
              end
            end
          end
        end
      end
    end
  end
end
