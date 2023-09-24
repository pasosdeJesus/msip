# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module PersonaTrelacion
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_persona_trelacion"
          belongs_to :personauno,
            foreign_key: "persona1",
            validate: true,
            class_name: "Msip::Persona",
            optional: false
          belongs_to :personados,
            foreign_key: "persona2",
            validate: true,
            class_name: "Msip::Persona",
            optional: false
          belongs_to :trelacion,
            validate: true,
            class_name: "Msip::Trelacion",
            optional: false

          accepts_nested_attributes_for :personados, reject_if: :all_blank
          accepts_nested_attributes_for :trelacion, reject_if: :all_blank

          validates_uniqueness_of :persona1, scope: [:persona2, :trelacion_id]

        end
      end
    end
  end
end
