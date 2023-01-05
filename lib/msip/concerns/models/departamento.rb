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
            foreign_key: "id_departamento",
            validate: true,
            class_name: "Msip::Municipio"
          has_many :persona,
            foreign_key: "id_departamento",
            validate: true,
            class_name: "Msip::Persona"
          has_many :ubicacion,
            foreign_key: "id_departamento",
            validate: true,
            class_name: "Msip::Ubicacion"

          belongs_to :pais,
            foreign_key: "id_pais",
            validate: true,
            class_name: "Msip::Pais",
            optional: false

          validates :id_pais, presence: true

          validates_uniqueness_of :nombre,
            scope: :id_pais,
            case_sensitive: false,
            message: "debe ser único en el país"
          validates_uniqueness_of :id_deplocal,
            scope: :id_pais,
            message: "debe ser único en el país",
            allow_blank: false

          # A nombre se le quitan espacios de sobra
          def nombre=(val)
            self[:nombre] = val.squish if val
          end

          scope :filtro_id_pais, lambda { |p|
            where(id_pais: p)
          }

          @@conf_presenta_nombre_con_origen = false
          mattr_accessor :conf_presenta_nombre_con_origen

          def presenta_nombre_con_origen
            pais = Msip::Pais.find(id_pais)
            nombre + " / " + pais.nombre
          end

          def presenta_nombre
            if @@conf_presenta_nombre_con_origen
              presenta_nombre_con_origen
            else
              nombre
            end
          end
        end

        class_methods do
          # mattr_accessor :conf_presenta_nombre_con_origen
        end
      end
    end
  end
end
