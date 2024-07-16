# frozen_string_literal: true

require "msip/concerns/models/grupoper"

module Msip
  # Grupo de personas.  Base para organización social
  class Grupoper < ActiveRecord::Base
    include Msip::Concerns::Models::Grupoper
  end
end
