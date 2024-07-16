# frozen_string_literal: true

require "msip/concerns/models/municipio"

module Msip
  # Tercer nivel en división político administrativa: municipio.
  # Ver {https://gitlab.com/pasosdeJesus/division-politica}
  class Municipio < ActiveRecord::Base
    include Msip::Concerns::Models::Municipio
  end
end
