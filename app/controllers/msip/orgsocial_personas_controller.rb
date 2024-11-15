# frozen_string_literal: true

require "msip/concerns/controllers/orgsocial_personas_controller"

module Msip
  class OrgsocialPersonasController < ApplicationController
    before_action :preparar_orgsocial_persona
    load_and_authorize_resource class: Msip::OrgsocialPersona

    include Msip::Concerns::Controllers::OrgsocialPersonasController
  end
end
