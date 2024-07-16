# frozen_string_literal: true

require "msip/concerns/models/departamento"

module Msip
  # Segundo nivel en división politico administrativa: departamento/estado.
  # Ver {https://gitlab.com/pasosdeJesus/division-politica}
  class Departamento < ActiveRecord::Base
    include Msip::Concerns::Models::Departamento
  end
end
