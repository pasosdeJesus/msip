# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module SolicitudUsuarionotificar
        extend ActiveSupport::Concern

        included do

          self.table_name = 'msip_solicitud_usuarionotificar'

          belongs_to :usuarionotificar, 
            class_name: 'Msip::Usuario', 
            foreign_key: "usuarionotificar_id", 
            inverse_of: :solicitud_usuarionotificar,
            optional: false,
            validate: false
          belongs_to :solicitud, 
            class_name: 'Msip::Solicitud', 
            foreign_key: "solicitud_id", 
            optional: false,
            validate: false

        end # included

      end
    end
  end
end
