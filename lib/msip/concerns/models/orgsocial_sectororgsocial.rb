# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Relación n:n entre organización social y sector de organización social
      module OrgsocialSectororgsocial
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_orgsocial_sectororgsocial"

          belongs_to :orgsocial, class_name: "Msip::Orgsocial", optional: false
          belongs_to :sectororgsocial, class_name: "Msip::Sectororgsocial", optional: false
        end # included
      end
    end
  end
end
