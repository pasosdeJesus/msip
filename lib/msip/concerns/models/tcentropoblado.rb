# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Tipo de centro poblado. Proviene de tipología del DANE para Colombia
      # (e.g Cabecera municipal, Área no municipalizada)
      module Tcentropoblado
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_tcentropoblado"
          has_many :centropoblado,
            foreign_key: "tcentropoblado_id",
            validate: true,
            class_name: "Msip::Centropoblado"

          validates :id,
            presence: true,
            allow_blank: false,
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
