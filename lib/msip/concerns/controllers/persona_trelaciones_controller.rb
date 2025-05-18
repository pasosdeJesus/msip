# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module PersonaTrelacionesController
        extend ActiveSupport::Concern

        included do
          def create
          end

          def destroy
            # render :destroy, layout: nil
          end

          private

          def preparar_persona_trelacion
            @registro = @persona = Msip::Persona.new(
              persona_trelacion1: [Msip::PersonaTrelacion.new],
            )
          end
        end # included
      end
    end
  end
end
