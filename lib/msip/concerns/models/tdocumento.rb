# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Tdocumento
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          self.table_name = "msip_tdocumento"
          validates :sigla, length: { maximum: 100 }, presence: true, uniqueness: true
          validates :formatoregex, length: { maximum: 500 }
        end
      end
    end
  end
end
