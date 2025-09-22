# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Etiqueta
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_etiqueta"

          has_many :etiqueta_persona,
            class_name: "Msip::EtiquetaPersona",
            foreign_key: "etiqueta_id",
            dependent: :delete_all
          has_many :persona,
            class_name: "Msip::Persona",
            through: :etiqueta_persona

          has_and_belongs_to_many :municipio,
            class_name: "Msip::Municipio",
            foreign_key: "etiqueta_id",
            association_foreign_key: "municipio_id",
            join_table: "msip_etiqueta_municipio"

          validates :nombre, presence: true, allow_blank: false
          validates :fechacreacion, presence: true, allow_blank: false
          validates :observaciones, length: { maximum: 500 }
        end
      end
    end
  end
end
