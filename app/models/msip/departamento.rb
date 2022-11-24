# frozen_string_literal: true

require "msip/concerns/models/departamento"

module Msip
  class Departamento < ActiveRecord::Base
    include Msip::Concerns::Models::Departamento
  end
end
