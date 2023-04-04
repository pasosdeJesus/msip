# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Ubicacion
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo

          self.table_name = "msip_ubicacion"
          belongs_to :pais,
            foreign_key: "pais_id",
            validate: true,
            class_name: "Msip::Pais",
            optional: false
          belongs_to :departamento,
            foreign_key: "departamento_id",
            validate: true,
            class_name: "Msip::Departamento",
            optional: true
          belongs_to :municipio,
            foreign_key: "municipio_id",
            validate: true,
            class_name: "Msip::Municipio",
            optional: true
          belongs_to :clase,
            foreign_key: "clase_id",
            validate: true,
            class_name: "Msip::Clase",
            optional: true
          belongs_to :tsitio,
            foreign_key: "tsitio_id",
            validate: true,
            class_name: "Msip::Tsitio",
            optional: true

          validates_presence_of :pais
          validates_presence_of :tsitio_id

          validates :lugar, length: { maximum: 500 }
          validates :sitio, length: { maximum: 500 }

          def presenta_nombre(opciones = {})
            sep = ""
            r = ""
            if opciones[:sin_pais].nil? && pais
              r = pais.nombre
              sep = " / "
            end
            if opciones[:sin_departamento].nil? && departamento
              r += sep + departamento.nombre
              sep = " / "
            end
            if opciones[:sin_municipio].nil? && municipio
              r += sep + municipio.nombre
              sep = " / "
            end
            if opciones[:sin_clase].nil? && clase
              r += sep + clase.nombre
              sep = " / "
            end
            r
          end
        end
      end
    end
  end
end
