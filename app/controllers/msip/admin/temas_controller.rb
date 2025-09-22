# frozen_string_literal: true

require "msip/concerns/controllers/temas_controller"

module Msip
  module Admin
    # Controlador de temas.
    class TemasController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::TemasController
    end
  end
end
