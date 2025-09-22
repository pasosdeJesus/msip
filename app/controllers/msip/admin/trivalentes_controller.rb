# frozen_string_literal: true

require "msip/concerns/controllers/trivalentes_controller"

module Msip
  module Admin
    # Controlador de tipos trivalentes.
    class TrivalentesController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::TrivalentesController
    end
  end
end
