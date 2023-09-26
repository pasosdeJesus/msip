# frozen_string_literal: true

require "msip/concerns/controllers/persona_trelaciones_controller"

module Msip
  class PersonaTrelacionesController < Msip::ModelosController
    load_and_authorize_resource class: Msip::Persona

    include Msip::Concerns::Controllers::PersonaTrelacionesController
  end
end
