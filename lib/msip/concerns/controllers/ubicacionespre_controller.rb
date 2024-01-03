# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module UbicacionespreController
        extend ActiveSupport::Concern

        included do
          def clase
            "Msip::Ubicacionpre"
          end

          def genclase
            "F"
          end

          def atributos_index
            [
              :id,
              :nombre,
              :pais,
              :departamento,
              :municipio,
              :centropoblado,
              :lugar,
              :sitio,
              :tsitio,
              :latitud,
              :longitud,
            ]
          end

          def atributos_show
            atributos_index
          end

          def atributos_form
            a = atributos_show - [:id]
            a
          end

          def mundep
            if params[:term]
              term = Msip::Ubicacion.connection.quote_string(params[:term])
              consNomubi = term.downcase.strip # sin_tildes
              consNomubi.gsub!(/ +/, ":* & ")
              unless consNomubi.empty?
                consNomubi += ":*"
              end
              # Usamos la funcion f_unaccent definida con el indice
              # en db/migrate/20200916022934_indice_ubicacionpre.rb
              where = " to_tsvector('spanish', " \
                "f_unaccent(ubicacionpre.nombre_sin_pais)) " \
                "@@ to_tsquery('spanish', '#{consNomubi}')"

              cons = "SELECT TRIM(nombre_sin_pais) AS value, id AS id " \
                "FROM public.msip_ubicacionpre AS ubicacionpre " \
                "WHERE #{where} AND pais_id=170 " \
                "AND centropoblado_id IS NULL " \
                "AND departamento_id IS NOT NULL " \
                "AND lugar IS NULL " \
                "AND sitio IS NULL " \
                " ORDER BY 1 LIMIT 10"

              r = ActiveRecord::Base.connection.select_all(cons)
              respond_to do |format|
                format.json { render(:json, inline: r.to_json) }
                format.html { render(inline: "No responde con parametro term") }
              end
            end
          end

          def index(c = nil)
            if c.nil?
              c = Msip::Ubicacionpre.all
            end
            if params[:term]
              term = Msip::Ubicacionpre.connection.quote_string(params[:term])
              consNomubi = term.downcase.strip # sin_tildes
              consNomubi.gsub!(/ +/, ":* & ")
              unless consNomubi.empty?
                consNomubi += ":*"
              end
              # Usamos la funcion f_unaccent definida con el indice
              # en db/migrate/20200916022934_indice_ubicacionpre.rb
              where = " to_tsvector('spanish', f_unaccent(ubicacionpre.nombre)) " \
                "@@ to_tsquery('spanish', '#{consNomubi}')"

              cons = "SELECT TRIM(nombre) AS value, id AS id " \
                "FROM public.msip_ubicacionpre AS ubicacionpre " \
                "WHERE #{where} ORDER BY 1 LIMIT 10"

              r = ActiveRecord::Base.connection.select_all(cons)
              respond_to do |format|
                format.json { render(:json, inline: r.to_json) }
                format.html { render(inline: "No responde con parametro term") }
              end
            else
              super(c)
            end
          end

          def set_ubicacionpre
            @ubicacionpre = Msip::Ubicacionpre.find(params[:id])
            @registro = @ubicacionpre
          end

          def ubicacionpre_params
            params.require(:ubicacionpre).permit(
              atributos_form,
            )
          end
        end
      end
    end
  end
end
