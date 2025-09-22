# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      # Tipo de relación entre dos personas (tipicamente familiares)
      module Trelacion
        extend ActiveSupport::Concern

        include Msip::Basica

        included do
          self.table_name = "msip_trelacion"
          has_many :persona_trelacion,
            foreign_key: "trelacion_id",
            validate: true,
            class_name: "Msip::PersonaTrelacion"

          # no puede usarse cuando es la misma
          # belongs_to :invtrelacion, foreign_key: "inverso",
          # validate: true, class_name: 'Msip::Trelacion'

          validates :id,
            presence: true,
            allow_blank: false,
            length: { maximum: 2 }
          validates_uniqueness_of :id, case_sensitive: false
          validates :inverso,
            presence: true,
            allow_blank: false,
            length: { maximum: 2 }
          validates :observaciones, length: { maximum: 200 }

          validate :inverso_existe

          def inverso_existe
            if inverso.present? && inverso != id &&
                Msip::Trelacion.find_by(id: inverso).nil?
              errors.add(:inverso, "no existe relacion con ese código")
            end
          end

          def id=(val)
            self[:id] = val.upcase.squish if val
          end

          def inverso=(val)
            self[:inverso] = val.upcase.squish if val
          end

          def validaciones_extra(errors)
            cp = Msip::Trelacion.joins(
              "JOIN msip_trelacion AS t2 ON t2.id=msip_trelacion.inverso",
            ).where("t2.inverso<>msip_trelacion.id")
            if cp.count > 0
              errors.add(
                :inverso,
                "Las siguientes relaciones tienen inverso errado #{cp.pluck(:id).join(",")}",
              )
            end
          end
        end
      end
    end
  end
end
