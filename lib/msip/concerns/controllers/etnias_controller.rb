# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module EtniasController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Etnia"
          end

          def set_etnia
            @basica = Etnia.find(params[:id])
          end

          def atributos_index
            [
              :id,
              :nombre,
              :descripcion,
              :observaciones,
              :fechacreacion_localizada,
              :habilitado
            ]
          end


          def etnia_params
            params.require(:etnia).permit(*atributos_form)
          end

        end # included
      end
    end
  end
end
