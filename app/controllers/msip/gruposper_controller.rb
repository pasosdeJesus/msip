# frozen_string_literal: true

require "msip/concerns/controllers/gruposper_controller"

module Msip
  # Controlador de grupos de personas.
  class GruposperController < ApplicationController
    load_and_authorize_resource class: Msip::Grupoper
    include Msip::Concerns::Controllers::GruposperController
  end
end
