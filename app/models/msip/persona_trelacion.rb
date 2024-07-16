# frozen_string_literal: true

require "msip/concerns/models/persona_trelacion"

module Msip
  # Relación entre dos personas y el tipo de relación (tipicamente familiares)
  class PersonaTrelacion < ActiveRecord::Base
    include Msip::Concerns::Models::PersonaTrelacion
  end
end
