# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module OrgsocialesController
        extend ActiveSupport::Concern

        included do
          def clase
            "Msip::Orgsocial"
          end

          def genclase
            "F"
          end

          def atributos_index
            [
              :id,
              :grupoper_id,
              :tipoorg_id,
              { sectororgsocial_ids: [] },
              { orgsocial_persona: [] },
              :web,
              :habilitado,
              :created_at,
            ]
          end

          def atributos_show
            [
              :id,
              :grupoper_id,
              :tipoorg_id,
              { sectororgsocial_ids: [] },
              { orgsocial_persona: [] },
              :web,
              :pais_id,
              :direccion,
              :telefono,
              :fax,
              :created_at_localizada,
              :fechadeshabilitacion_localizada,
            ]
          end

          def atributos_form
            a = atributos_show - [
              :id,
              :created_at_localizada,
              :fechadeshabilitacion_localizada,
            ] + [
              :fechadeshabilitacion,
            ]
            a[a.index(:grupoper_id)] = :grupoper
            a
          end

          def index(c = nil)
            if c.nil?
              c = Msip::Orgsocial.all
            end
            if params[:term]
              # usado en autocompletación limitado a 10
              term = Msip::Orgsocial.connection.quote_string(params[:term])
              consNoment = term.downcase.strip # sin_tildes
              consNoment.gsub!(/ +/, ":* & ")
              unless consNoment.empty?
                consNoment += ":*"
              end
              where = " to_tsvector('spanish', unaccent(grupoper.nombre)  " \
                "|| ' ' || COALESCE(orgsocial.id::TEXT, '')) @@ " \
                "to_tsquery('spanish', '#{consNoment}')"

              partes = [
                "nombre",
                "COALESCE(orgsocial.id::TEXT, '')",
              ]
              s = ""
              l = " grupoper.id "
              seps = ""
              sepl = " || ';' || "
              partes.each do |p|
                s += seps + p
                l += sepl + "char_length(#{p})"
                seps = " || ' ' || "
              end
              qstring = "SELECT TRIM(#{s}) AS value, #{l} AS id
              FROM public.msip_orgsocial AS orgsocial
              JOIN public.msip_grupoper AS grupoper
                ON grupoper.id=orgsocial.grupoper_id
              WHERE #{where} ORDER BY 1 LIMIT 10"

              r = ActiveRecord::Base.connection.select_all(qstring)
              respond_to do |format|
                format.json { render(:json, inline: r.to_json) }
                format.html { render(inline: "No responde con parametro term") }
              end
            else
              super
            end
          end

          def set_orgsocial
            @orgsocial = Msip::Orgsocial.find(params[:id])
            @registro = @orgsocial
          end

          def update
            if params && params[:orgsocial] &&
                params[:orgsocial][:orgsocial_persona_attributes]
              op_params = params[:orgsocial][:orgsocial_persona_attributes]
              op_params.each do |_clave, valor|
                next unless
                  valor[:id] == "" && valor[:_destroy] != "true" &&
                    valor[:persona_attributes][:id]

                op = Msip::OrgsocialPersona.create(
                  correo: valor[:correo],
                  orgsocial_id: @registro.id,
                  perfilorgsocial_id: valor[:perfilorgsocial_id],
                  cargo: valor[:cargo],
                  persona_id: valor[:persona_attributes][:id],
                )
                valor[:id] = op.id.to_s
              end
            end
            update_gen(@registro)
          end

          def lista_params_msip
            atributos_form - [:grupoper] +
              [
                :pais_id,
                grupoper_attributes: [
                  :id,
                  :nombre,
                  :anotaciones,
                ],
                orgsocial_persona_attributes: [
                  :id,
                  :perfilorgsocial_id,
                  :cargo,
                  :correo,
                  :_destroy,
                  persona_attributes: [
                    :id,
                    :nombres,
                    :apellidos,
                    :sexo,
                  ],
                ],
              ]
          end

          def orgsocial_params
            params.require(:orgsocial).permit(lista_params_msip)
          end
        end # included
      end
    end
  end
end
