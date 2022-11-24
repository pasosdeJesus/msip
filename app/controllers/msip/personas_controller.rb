# frozen_string_literal: true

require "msip/concerns/controllers/personas_controller"

module Msip
  class PersonasController < Msip::ModelosController
    load_and_authorize_resource class: Msip::Persona

    include Msip::Concerns::Controllers::PersonasController
  end
end
