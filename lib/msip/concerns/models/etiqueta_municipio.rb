# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module EtiquetaMunicipio
        extend ActiveSupport::Concern

        include Msip::Localizacion
        include Msip::FormatoFechaHelper

        included do
          self.table_name = "msip_etiqueta_municipio"

          self.primary_key = [:etiqueta_id, :municipio_id]

          belongs_to :municipio,
            class_name: "Msip::Municipio",
            optional: false,
            validate: false
          belongs_to :etiqueta,
            class_name: "Msip::Etiqueta",
            optional: false,
            validate: false
        end # included
      end
    end
  end
end
