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
            validate: true,
            class_name: "Msip::Pais",
            optional: false
          belongs_to :departamento,
            validate: true,
            class_name: "Msip::Departamento",
            optional: true
          belongs_to :municipio,
            validate: true,
            class_name: "Msip::Municipio",
            optional: true
          belongs_to :centropoblado,
            validate: true,
            class_name: "Msip::Centropoblado",
            optional: true
          belongs_to :tsitio,
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
            if opciones[:sin_centropoblado].nil? && centropoblado
              r += sep + centropoblado.nombre
              " / "
            end
            r
          end
        end
      end
    end
  end
end
