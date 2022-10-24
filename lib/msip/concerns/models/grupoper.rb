
module Msip
  module Concerns
    module Models
      module Grupoper
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo 
          include Msip::Localizacion

          self.table_name = 'msip_grupoper'

          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 500 }
          validates :anotaciones, length: { maximum: 500 }

          def presenta_nombre
            self.nombre
          end

        end

        class_methods do

        end

      end
    end
  end
end

