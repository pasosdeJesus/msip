module Msip
  module Concerns
    module Models
      module GrupoUsuario
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_grupo_usuario"

          belongs_to :grupo, class_name: "Msip::Grupo", validate: true, optional: false
          belongs_to :usuario, class_name: "::Usuario", validate: true, optional: false
        end
      end
    end
  end
end
