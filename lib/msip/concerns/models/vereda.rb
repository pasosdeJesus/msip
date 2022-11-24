module Msip
  module Concerns
    module Models
      module Vereda
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          Nombresunicos = false  # Por ejemplo hay vereda SAN ANTONIO en 146 municipios
          self.table_name = "msip_vereda"

          belongs_to :municipio,
            validate: true, class_name: "Msip::Municipio", optional: false
          has_one :departamento, through: :municipio,
            class_name: "Msip::Departamento", source: :departamento
          has_one :pais, through: :departamento,
            class_name: "Msip::Pais", source: :pais

          validates :municipio_id, presence: true

          validates_uniqueness_of :verlocal_id,
            scope: :municipio_id,
            message: "debe ser único en el municipio",
            allow_blank: true

          #          validates_uniqueness_of :nombre,
          #            scope: :municipio_id,
          #            case_sensitive: false,
          #            message: "debe ser único en el municpio"

          scope :filtro_pais, lambda { |p|
            joins(:municipio).joins(:departamento).joins(:pais)
              .where("unaccent(msip_pais.nombre) ILIKE '%' || unaccent(?) || '%'", p)
          }

          scope :filtro_departamento, lambda { |d|
            joins(:municipio).joins(:departamento)
              .where("unaccent(msip_departamento.nombre) ILIKE '%' || unaccent(?) || '%'", d)
          }

          scope :filtro_municipio_id, lambda { |m|
            joins(:municipio)
              .where("unaccent(msip_municipio.nombre) ILIKE '%' || unaccent(?) || '%'", m)
          }

          @@conf_presenta_nombre_con_origen = false
          mattr_accessor :conf_presenta_nombre_con_origen

          def presenta_nombre_con_origen
            mun = Msip::Municipio.find(municipio_id)
            dep = Msip::Departamento.find(mun.id_departamento)
            pais = Msip::Pais.find(dep.id_pais)
            "VEREDA: " + nombre + " / " + mun.nombre + "/" + dep.nombre +
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
