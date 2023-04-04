# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Departamento
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          Nombresunicos = false # Por ejemplo hay departamento AMAZONAS en COLOMBIA y en VENEZUELA
          self.table_name = "msip_departamento"
          has_many :municipio,
            foreign_key: "departamento_id",
            validate: true,
            class_name: "Msip::Municipio"
          has_many :persona,
            foreign_key: "departamento_id",
            validate: true,
            class_name: "Msip::Persona"
          has_many :ubicacion,
            foreign_key: "departamento_id",
            validate: true,
            class_name: "Msip::Ubicacion"

          belongs_to :pais,
            foreign_key: "pais_id",
            validate: true,
            class_name: "Msip::Pais",
            optional: false

          validates :pais_id, presence: true

          validates_uniqueness_of :nombre,
            scope: :pais_id,
            case_sensitive: false,
            message: "debe ser único en el país"
          validates_uniqueness_of :deplocal_cod,
            scope: :pais_id,
            message: "debe ser único en el país",
            allow_blank: false

          # A nombre se le quitan espacios de sobra
          def nombre=(val)
            self[:nombre] = val.squish if val
          end

          scope :filtro_pais_id, lambda { |p|
            where(pais_id: p)
          }

          @@conf_presenta_nombre_con_origen = false
          mattr_accessor :conf_presenta_nombre_con_origen

          def presenta_nombre_con_origen
            pais = Msip::Pais.find(pais_id)
            nombre + " / " + pais.nombre
          end

          def presenta_nombre
            if @@conf_presenta_nombre_con_origen
              presenta_nombre_con_origen
            else
              nombre
            end
          end

          # Código local, e.g en Colombia DIVIPOLA
          def codlocal
            deplocal_cod
          end
        end

        class_methods do
          # mattr_accessor :conf_presenta_nombre_con_origen
        end
      end
    end
  end
end
