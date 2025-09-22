# frozen_string_literal: true

require "msip/concerns/controllers/respaldo7z_controller"

# http://stackoverflow.com/questions/1170148/run-rake-task-in-controller
require "rake"
Rake::Task.clear # evitar cargar muchas veces en modo desarrollo
Rails.application.load_tasks

module Msip
  # Controlador para la gestión de respaldos cifrados.
  class Respaldo7zController < ApplicationController
    load_and_authorize_resource class: Msip::Respaldo7z

    include Msip::Concerns::Controllers::Respaldo7zController
  end
end
