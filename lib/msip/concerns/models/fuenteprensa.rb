module Msip
  module Concerns
    module Models
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
