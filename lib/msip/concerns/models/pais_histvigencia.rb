# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module PaisHistvigencia
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_pais_histvigencia"

          belongs_to :pais,
            class_name: "Msip::Pais",,
            optional: false,
            validate: false
        end # included
      end
    end
  end
end
