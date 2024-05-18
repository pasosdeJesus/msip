module Msip
  module Concerns
    module Controllers
      module EtiquetasPersonaController
        extend ActiveSupport::Concern

        included do

          def create
          end
          
          def destroy
          end

          private

          def preparar_etiqueta_persona
            @registro = @persona = Msip::Persona.new(
              etiqueta_persona: [Msip::EtiquetaPersona.new]
            )
          end

        end # included

      end
    end
  end
end
