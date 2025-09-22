# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Primer nivel en división político administrativa: país. 
      # Ver: https://gitlab.com/pasosdeJesus/division-politica
      module Pais
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_pais"
          has_many :departamento,
            foreign_key: "pais_id",
            validate: true,
            class_name: "Msip::Departamento"
          has_one :personanacionalde,
            foreign_key: "nacionalde",
            validate: true,
            class_name: "Msip::Persona"
          has_one :personapais,
            foreign_key: "pais_id",
            class_name: "Msip::Persona"
          has_many :ubicacion,
            foreign_key: "pais_id",
            validate: true,
            class_name: "Msip::Ubicacion"

          flotante_localizado :latitud, :longitud

          validates :id, presence: true, uniqueness: true
          validates :nombreiso_espanol,
            presence: true,
            allow_blank: false,
            length: { maximum: 200 },
            uniqueness: { case_sensitive: false, allow_blank: true }
          validates :nombre,
            presence: true,
            allow_blank: false,
            length: { maximum: 200 },
            uniqueness: { case_sensitive: false, allow_blank: true }
          validates :alfa2,
            length: { maximum: 2 },
            uniqueness: { case_sensitive: false, allow_blank: true }
          validates :alfa3,
            length: { maximum: 3 },
            uniqueness: { case_sensitive: false, allow_blank: true }
          validates :div1, length: { maximum: 100 }
          validates :div2, length: { maximum: 100 }
          validates :div3, length: { maximum: 100 }

          # A nombre se le quitan espacios de sobra
          def nombre=(val)
            self[:nombre] = val.squish if val
          end
        end
      end
    end
  end
end
