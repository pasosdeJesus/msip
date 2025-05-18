# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module TsitiosController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Tsitio"
          end

          def set_tsitio
            @basica = Tsitio.find(params[:id])
          end

          def genclase
            "M"
          end

          def tsitio_params
            params.require(:tsitio).permit(*atributos_form)
          end
        end # included
      end
    end
  end
end
