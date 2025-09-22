# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Oficina
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_oficina"

          validates :observaciones, length: { maximum: 5000 }
        end
      end
    end
  end
end
