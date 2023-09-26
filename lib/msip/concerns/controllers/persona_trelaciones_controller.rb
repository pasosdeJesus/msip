# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module PersonaTrelacionesController
        extend ActiveSupport::Concern

        included do

          before_action :prepara

          def create
          end

          def destroy
          end

          private

          def prepara
            @persona = Msip::Persona.new(
              persona_trelacion1: [Msip::PersonaTrelacion.new]
            )
          end

        end # included

      end
    end
  end
end
