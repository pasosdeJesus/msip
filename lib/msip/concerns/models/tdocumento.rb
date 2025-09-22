# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Tipo de documento de identidad (e.g Cédula, Pasaporte)
      module Tdocumento
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_tdocumento"
          validates :sigla, length: { maximum: 100 }, presence: true
          validates :formatoregex, length: { maximum: 500 }
        end
      end
    end
  end
end
