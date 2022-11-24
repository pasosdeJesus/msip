# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module SectoresorgsocialController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          before_action :set_sectororgsocial,
            only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource class: Msip::Sectororgsocial

          def clase
            "Msip::Sectororgsocial"
          end

          def set_sectororgsocial
            @basica = Msip::Sectororgsocial.find(params[:id])
          end

          def atributos_index
            [
              :id,
              :nombre,
              :observaciones,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def genclase
            "M"
          end

          def sectororgsocial_params
            params.require(:sectororgsocial).permit(*atributos_form)
          end
        end
      end
    end
  end
end
