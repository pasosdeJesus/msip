# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Sectororgsocial
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion
          include Msip::Basica

          self.table_name = "msip_sectororgsocial"

          has_and_belongs_to_many :orgsocial,
            class_name: "Msip::Orgsocial",
            foreign_key: "sectororgsocial_id",
            validate: true,
            association_foreign_key: "orgsocial_id",
            join_table: "msip_orgsocial_sectororgsocial"
        end
      end
    end
  end
end
