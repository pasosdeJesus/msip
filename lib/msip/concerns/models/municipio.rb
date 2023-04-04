# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Municipio
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          Nombresunicos = false # Por ejemplo hay departamento AMAZONAS en COLOMBIA y en VENEZUELA
          self.table_name = "msip_municipio"

          has_many :clase,
            foreign_key: "municipio_id",
            validate: true,
            class_name: "Msip::Clase"
          has_many :persona,
            foreign_key: "municipio_id",
            validate: true,
            class_name: "Msip::Persona"
          has_many :ubicacion,
            foreign_key: "municipio_id",
            validate: true,
            class_name: "Msip::Ubicacion"

          belongs_to :departamento,
            foreign_key: "departamento_id",
            validate: true,
            class_name: "Msip::Departamento",
            optional: false
          has_one :pais,
            through: :departamento,
            class_name: "Msip::Pais",
            source: :pais

          has_and_belongs_to_many :etiqueta,
            class_name: "Msip::Etiqueta",
            foreign_key: "municipio_id",
            association_foreign_key: "etiqueta_id",
            join_table: "msip_etiqueta_municipio"

          validates :departamento_id, presence: true

          validates_uniqueness_of :nombre,
            scope: :departamento_id,
            case_sensitive: false,
            message: "debe ser único en el departamento/estado"
          validates_uniqueness_of :munlocal_cod,
            scope: :departamento_id,
            case_sensitive: false,
            message: "debe ser único en el departamento/estado",
            allow_blank: false

          # A nombre se le quitan espacios de sobra
          def nombre=(val)
            self[:nombre] = val.squish if val
          end

          scope :filtro_pais, lambda { |p|
            joins(:departamento).where("msip_departamento.pais_id=?", p)
          }

          scope :filtro_etiqueta_ids, lambda { |e|
            joins(:etiqueta).where(msip_etiqueta: { id: e })
          }

          scope :filtro_tipomun, lambda { |t|
            where("unaccent(lower(tipomun)) ILIKE ?", "%#{t}%")
          }

          @@conf_presenta_nombre_con_origen = false
          mattr_accessor :conf_presenta_nombre_con_origen

          @@conf_presenta_nombre_con_departamento = false
          mattr_accessor :conf_presenta_nombre_con_departamento

          def presenta_nombre_con_departamento
            dep = Msip::Departamento.find(departamento_id)
            nombre + " / " + dep.nombre
          end

          def presenta_nombre_con_origen
            dep = Msip::Departamento.find(departamento_id)
            pais = Msip::Pais.find(dep.pais_id)
            nombre + " / " + dep.nombre + " / " + pais.nombre
          end

          def presenta_nombre
            if @@conf_presenta_nombre_con_departamento
              presenta_nombre_con_departamento
            elsif @@conf_presenta_nombre_con_origen
              presenta_nombre_con_origen
            else
              nombre
            end
          end

          # Código local, e.g en Colombia DIVIPOLA
          def codlocal
            departamento.deplocal_cod * 1000 + munlocal_cod
          end
        end
      end
    end
  end
end
