# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module EtiquetasController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Etiqueta"
          end

          def set_etiqueta
            @basica = Etiqueta.find(params[:id])
          end

          def etiqueta_params
            params.require(:etiqueta).permit(*atributos_form)
          end

        end # included
      end
    end
  end
end
