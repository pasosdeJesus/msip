module Msip
  module Concerns
    module Controllers
      module SolicitudesController
        extend ActiveSupport::Concern

        included do
          def clase
            "Msip::Solicitud"
          end

          def set_solicitud
            @basica = Msip::Solicitud.find(params[:id])
          end

          def atributos_index
            [
              :id,
              :usuario_id,
              :fecha,
              :solicitud,
              :estadosol_id,
              :usuarionotificar_ids,
            ]
          end

          def atributos_form
            [
              :id,
              :usuario_id,
              :fecha,
              :solicitud,
              :estadosol_id,
              :usuarionotificar_ids,
            ]
          end

          def genclase
            "F"
          end

          def params_lista
            atributos_form
          end

          def solicitud_params
            params.require(:solicitud).permit(params_lista)
          end
        end # included
      end
    end
  end
end
