# frozen_string_literal: true

require "msip/concerns/models/departamento_histvigencia"

module Msip
  # Historial de vigencia de departamentos deshabilitados
  class DepartamentoHistvigencia < ActiveRecord::Base
    include Msip::Concerns::Models::DepartamentoHistvigencia
  end
end
