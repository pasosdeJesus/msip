# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module DepartamentoHistvigencia
        extend ActiveSupport::Concern

        included do
          self.table_name = "msip_departamento_histvigencia"

          belongs_to :departamento,
            class_name: "Msip::Departamento",
            optional: false,
            validate: false
        end # included
      end
    end
  end
end
