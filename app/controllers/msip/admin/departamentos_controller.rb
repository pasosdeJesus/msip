# frozen_string_literal: true

require "msip/concerns/controllers/departamentos_controller"

module Msip
  module Admin
    # Controlador de departamentos.
    class DepartamentosController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::DepartamentosController
    end
  end
end
