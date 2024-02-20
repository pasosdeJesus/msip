# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Etnia
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_etnia"

          has_many :persona, class_name: 'Msip::Persona',
            foreign_key: 'etnia_id', dependent: :delete_all

          validates :nombre, presence: true, allow_blank: false
          validates :fechacreacion, presence: true, allow_blank: false
          validates :descripcion, length: { maximum: 1000}
        end
      end
    end
  end
end
