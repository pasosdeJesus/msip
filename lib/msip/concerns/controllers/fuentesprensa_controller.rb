# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module FuentesprensaController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Fuenteprensa"
          end

          def set_fuenteprensa
            @basica = Fuenteprensa.find(params[:id])
          end

          def fuenteprensa_params
            params.require(:fuenteprensa).permit(*atributos_form)
          end
        end # included
      end
    end
  end
end
