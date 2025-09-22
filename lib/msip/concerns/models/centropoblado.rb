# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Centropoblado
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          Nombresunicos = false # Por ejemplo hay departamento AMAZONAS en COLOMBIA y en VENEZUELA
          self.table_name = "msip_centropoblado"
          has_many :persona,
            foreign_key: "centropoblado_id",
            validate: true,
            class_name: "Msip::Persona"
          has_many :ubicacion,
            foreign_key: "centropoblado_id",
            validate: true,
            class_name: "Msip::Ubicacion"

          belongs_to :municipio,
            validate: true,
            class_name: "Msip::Municipio",
            optional: false
          has_one :departamento,
            through: :municipio,
            class_name: "Msip::Departamento",
            source: :departamento
          has_one :pais,
            through: :departamento,
            class_name: "Msip::Pais",
            source: :pais

          belongs_to :tcentropoblado,
            validate: true,
            class_name: "Msip::Tcentropoblado",
            optional: false

          # A nombre se le quitan espacios de sobra
          def nombre=(val)
            self[:nombre] = val.squish if val
          end

          validates :municipio_id, presence: true
          validates :tcentropoblado_id, presence: true, length: { maximum: 10 }

          validates_uniqueness_of :cplocal_cod,
            scope: :municipio_id,
            message: "debe ser único en el municipio",
            allow_blank: true

          validates_uniqueness_of :nombre,
            scope: :municipio_id,
            case_sensitive: false,
            message: "debe ser único en el municpio"

          scope :filtro_pais, lambda { |p|
            joins(:municipio).joins(:departamento)
              .where("msip_departamento.pais_id=?", p)
          }

          @@conf_presenta_nombre_con_origen = false
          mattr_accessor :conf_presenta_nombre_con_origen

          def presenta_nombre_con_origen
            mun = Msip::Municipio.find(municipio_id)
            dep = Msip::Departamento.find(mun.departamento_id)
            pais = Msip::Pais.find(dep.pais_id)
            nombre + " / " + mun.nombre + "/" + dep.nombre +
              " / " + pais.nombre
          end

          def presenta_nombre
            if @@conf_presenta_nombre_con_origen
              presenta_nombre_con_origen
            else
              nombre
            end
          end
        end
      end
    end
  end
end
