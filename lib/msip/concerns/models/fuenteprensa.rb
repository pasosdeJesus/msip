# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Fuente de prensa. Listado inicial para Colombia de periodicos recientes.
      module Fuenteprensa
        extend ActiveSupport::Concern
        include Msip::Basica

        included do
          self.table_name = "msip_fuenteprensa"
        end
      end
    end
  end
end
