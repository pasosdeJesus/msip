# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Tclase
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          self.table_name = "msip_tclase"
          has_many :clase, foreign_key: "id_tclase", validate: true,
            class_name: "Msip::Clase"

          validates :id, presence: true, allow_blank: false,
            length: { maximum: 10 }
          validates_uniqueness_of :id, case_sensitive: false

          def id=(val)
            self[:id] = val.upcase.squish if val
          end
        end
      end
    end
  end
end
