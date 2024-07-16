# frozen_string_literal: true

require "msip/concerns/models/trivalente"

module Msip
  # Respuesta Si, No, Sin Información
  class Trivalente < ActiveRecord::Base
    include Msip::Concerns::Models::Trivalente
  end
end
