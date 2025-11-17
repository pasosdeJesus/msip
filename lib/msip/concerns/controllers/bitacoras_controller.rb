# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module BitacorasController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          # Bitácora es solo lectura - registros creados automáticamente por el sistema
          # No debe tener formularios ni permitir creación/edición manual (issue #6)

          def clase
            "Msip::Bitacora"
          end

          def atributos_index
            [
              :id,
              :fecha,
              :ip,
              :usuario_id,
              :url,
              :modelo,
              :modelo_id,
              :operacion,
              :detalle,
            ]
          end

          def index_reordenar(registros)
            registros.order(created_at: :desc)
          end

          def genclase
            "F"
          end

          def destroy
            debugger
          end

          private

          def set_bitacora
            @registro = @bitacora = Msip::Bitacora.find(params[:id].to_i)
          end
        end
      end
    end
  end
end
