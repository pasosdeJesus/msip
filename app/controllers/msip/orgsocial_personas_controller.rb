# frozen_string_literal: true

require "msip/concerns/controllers/orgsocial_personas_controller"

module Msip
  # Controlador de asociaciones entre organizaciones sociales y personas.
  class OrgsocialPersonasController < ApplicationController
    before_action :preparar_orgsocial_persona
    load_and_authorize_resource class: Msip::Orgsocial

    include Msip::Concerns::Controllers::OrgsocialPersonasController
  end
end
