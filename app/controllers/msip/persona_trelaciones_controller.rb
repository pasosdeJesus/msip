# frozen_string_literal: true

require "msip/concerns/controllers/persona_trelaciones_controller"

module Msip
  # Controlador de relaciones entre personas.
  class PersonaTrelacionesController < ApplicationController
    before_action :preparar_persona_trelacion
    load_and_authorize_resource class: Msip::PersonaTrelacion

    include Msip::Concerns::Controllers::PersonaTrelacionesController
  end
end
