# frozen_string_literal: true

require "msip/concerns/models/vereda"

module Msip
  # Cuarto nivel en la división político administrativa cuando la ubicación
  # es rural.
  # Ver {https://gitlab.com/pasosdeJesus/division-politica}
  class Vereda < ActiveRecord::Base
    include Msip::Concerns::Models::Vereda
  end
end
