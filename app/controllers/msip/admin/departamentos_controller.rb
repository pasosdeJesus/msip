require "msip/concerns/controllers/departamentos_controller"

module Msip
  module Admin
    class DepartamentosController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::DepartamentosController
    end
  end
end
