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
              :created_at_localizada,
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
            a = atributos_show - [:id, :created_at_localizada]
            a[a.index(:grupoper_id)] = :grupoper
            a
          end

          def index(c = nil)
            if c.nil?
              c = Msip::Orgsocial.all
            end
            super(c)
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
                next unless valor[:id] == ""

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
