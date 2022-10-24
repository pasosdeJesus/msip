
module Msip
  module Concerns
    module Models
      module Tsitio
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          self.table_name = 'msip_tsitio'
          has_many :ubicacion, foreign_key: "id_tsitio", validate: true,
            class_name: 'Msip::Ubicacion'
        end
      end
    end
  end
end

