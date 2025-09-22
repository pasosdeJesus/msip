# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Grupo de usuarios.  Puede relacionarse con organigrama.
      # Útil por ejemplo para dar/quitar acceso.
      module Grupo
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_grupo"

          # Nombre de grupo puede tener minúscula/mayúscula
          def nombre=(val)
            self[:nombre] = val.squish if val
          end

          has_and_belongs_to_many :usuario,
            class_name: "::Usuario",
            foreign_key: "grupo_id",
            association_foreign_key: "usuario_id",
            join_table: "msip_grupo_usuario",
            validate: true
        end
      end
    end
  end
end
