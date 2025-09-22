# frozen_string_literal: true

module Msip
  module Concerns
    # Relación n:n entre persona y organización social
    module Models
      module OrgsocialPersona
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          self.table_name = "msip_orgsocial_persona"

          belongs_to :orgsocial,
            class_name: "Msip::Orgsocial",
            inverse_of: :orgsocial_persona,
            optional: true
          belongs_to :persona,
            class_name: "Msip::Persona",
            optional: false,
            validate: true
          accepts_nested_attributes_for :persona,
            reject_if: :all_blank

          belongs_to :perfilorgsocial,
            class_name: "Msip::Perfilorgsocial",
            optional: true,
            validate: true
        end # included
      end
    end
  end
end
