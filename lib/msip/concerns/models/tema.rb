# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Tema para la interfaz del sistema de información. Actualmente colores de
      # varios elementos.
      module Tema
        extend ActiveSupport::Concern

        included do
          include Msip::Basica

          self.table_name = "msip_tema"

          def excepciones_al_copiar_asociaciones
            []
          end

          def copiar_especifico(registro)
          end
        end
      end
    end
  end
end
