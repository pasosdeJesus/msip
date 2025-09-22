# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Relacion n-n entre usuario y grupo
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
