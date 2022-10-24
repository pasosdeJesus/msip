module Msip
  module Concerns
    module Models
      module Estadosol
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = 'msip_estadosol'

          PENDIENTE = 1
          RESUELTO = 2
        end
      end
    end
  end
end
