# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module PersonaTrelacion
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_persona_trelacion"
          belongs_to :personauno,
            class_name: "Msip::Persona",
            foreign_key: "persona1",
            optional: false,
            validate: true
          belongs_to :personados,
            class_name: "Msip::Persona",
            foreign_key: "persona2",
            optional: false,
            validate: true
          belongs_to :trelacion,
            class_name: "Msip::Trelacion",
            optional: false,
            validate: true

          accepts_nested_attributes_for :personados, 
            reject_if: :all_blank
          accepts_nested_attributes_for :trelacion, 
            reject_if: :all_blank

          validates_uniqueness_of :persona1, scope: [:persona2, :trelacion_id]

          validate :vdiferentes
          def vdiferentes
            if persona1 == persona2 && !persona1.nil? && !persona2.nil?
              errors.add(:persona1, 
                         "Una persona no puede ser familiar de si misma")
            end
          end

          validate :vmaximo_una
          def vmaximo_una
            prep = Msip::PersonaTrelacion.where(persona1: persona1).
                where(persona2: persona2).pluck(:id)
            if prep.count >=2 || 
                (self.id && prep.count == 1 && !prep.include?(self.id))
              errors.add(:persona1, 
                         "Ya hay una relacion entre #{persona1} y #{persona2}")
            end
          end



        end
      end
    end
  end
end
