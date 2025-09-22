# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Tipo de sitio, (e.g rural, urbano)
      module Tsitio
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_tsitio"
          has_many :ubicacion,
            foreign_key: "tsitio_id",
            validate: true,
            class_name: "Msip::Ubicacion"
        end
      end
    end
  end
end
