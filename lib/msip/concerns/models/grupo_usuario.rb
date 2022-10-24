
module Msip
  module Concerns
    module Models
      module GrupoUsuario
        extend ActiveSupport::Concern

        included do
          self.table_name = 'msip_grupo_usuario'

          belongs_to :msip_grupo, class_name: 'Msip::Grupo',
            foreign_key: 'msip_grupo_id', validate: true, optional: false
          belongs_to :usuario, class_name: '::Usuario',
            foreign_key: 'usuario_id', validate: true, optional: false
        end

      end
    end
  end
end

