module Msip
  module Concerns
    module Models
      module Perfilorgsocial
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion
          include Msip::Basica

          self.table_name = "msip_perfilorgsocial"
        end # included
      end
    end
  end
end
