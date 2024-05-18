module Msip
  module Concerns
    module Controllers
      module OrgsocialPersonasController
        extend ActiveSupport::Concern

        included do

          def destroy
          end

          def create
          end

          private

          def preparar_orgsocial_persona
            @registro = @orgsocial = Msip::Orgsocial.new(orgsocial_persona: [Msip::OrgsocialPersona.new])
          end
        end # included

      end
    end
  end
end

