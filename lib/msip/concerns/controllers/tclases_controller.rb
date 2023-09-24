# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module TclasesController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Tclase"
          end

          def set_tclase
            @basica = Tclase.find(params[:id])
          end

          def atributos_index
            [
              "id",
              "nombre",
              "observaciones",
              "fechacreacion_localizada",
              "habilitado",
            ]
          end

          def atributos_form
            atributos_show
          end

          def genclase
            "M"
          end

          def tclase_params
            params.require(:tclase).permit(*atributos_form)
          end

        end
      end
    end
  end
end


