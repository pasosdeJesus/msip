# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module EtiquetaPersona
        extend ActiveSupport::Concern

        include Msip::Localizacion
        include Msip::FormatoFechaHelper

        included do

          self.table_name = 'msip_etiqueta_persona'

          belongs_to :persona, foreign_key: "persona_id", validate: false,
            class_name: 'Msip::Persona', inverse_of: :etiqueta_persona,
            optional: false
          belongs_to :etiqueta, foreign_key: "etiqueta_id", validate: false,
            class_name: 'Msip::Etiqueta', optional: false
          belongs_to :usuario, foreign_key: "usuario_id", validate: false, 
            optional: false

          campofecha_localizado :fecha

          validates_presence_of :fecha

        end # included

      end
    end
  end
end

