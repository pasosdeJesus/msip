# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Una solicitud de un usuario a otro
      module Solicitud
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          PENDIENTE = 1
          RESUELTA = 2

          self.table_name = "msip_solicitud"

          belongs_to :usuario,
            class_name: "Usuario",
            optional: false
          belongs_to :estadosol,
            validate: true,
            class_name: "Msip::Estadosol",
            optional: true

          has_and_belongs_to_many :usuarionotificar,
            class_name: "Usuario",
            foreign_key: :solicitud_id,
            association_foreign_key: "usuarionotificar_id",
            join_table: "msip_solicitud_usuarionotificar"

          campofecha_localizado :fecha

          validates :fecha, presence: true
          validates :solicitud,
            length: { maximum: 5000 },
            presence: true,
            allow_blank: false
        end # included
      end
    end
  end
end
