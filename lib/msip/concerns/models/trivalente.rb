# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Trivalente
        extend ActiveSupport::Concern

        included do
          include Msip::Basica

          self.table_name = "msip_trivalente"
        end # included
      end
    end
  end
end
