# frozen_string_literal: true

require "msip/concerns/controllers/persona_trelaciones_controller"

module Msip
  class PersonaTrelacionesController < Msip::ModelosController
    include Msip::Concerns::Controllers::PersonaTrelacionesController
  end
end
