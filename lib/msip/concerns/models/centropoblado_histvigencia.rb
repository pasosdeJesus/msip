# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Historial de vigencia de centros poblados deshabilitados
      module CentropobladoHistvigencia
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_centropoblado_histvigencia"

          belongs_to :centropoblado,
            class_name: "Msip::Centropoblado",
            optional: false,
            validate: false
        end # included
      end
    end
  end
end
