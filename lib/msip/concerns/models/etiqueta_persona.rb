# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module EtiquetaPersona
        extend ActiveSupport::Concern

        include Msip::Localizacion
        include Msip::FormatoFechaHelper

        included do
          self.table_name = "msip_etiqueta_persona"

          belongs_to :persona,
            class_name: "Msip::Persona",,
            inverse_of: :etiqueta_persona,
            optional: false,
            validate: false
          belongs_to :etiqueta,
            class_name: "Msip::Etiqueta",,
            optional: false,
            validate: false
          belongs_to :usuario,,
            optional: false,
            validate: false

          campofecha_localizado :fecha

          validates_presence_of :fecha
        end # included
      end
    end
  end
end
