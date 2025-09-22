# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Historial de vigencia de municipios deshabilitados
      module MunicipioHistvigencia
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_municipio_histvigencia"

          belongs_to :municipio,
            class_name: "Msip::Municipio",
            optional: false,
            validate: false
        end # included
      end
    end
  end
end
