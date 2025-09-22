# frozen_string_literal: true

require "msip/concerns/controllers/paises_controller"

module Msip
  module Admin
    # Controlador de países.
    class PaisesController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::PaisesController
    end
  end
end
