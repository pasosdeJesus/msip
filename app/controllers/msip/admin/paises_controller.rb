require 'msip/concerns/controllers/paises_controller'

module Msip
  module Admin
    class PaisesController < Msip::Admin::BasicasController

      include Msip::Concerns::Controllers::PaisesController

    end
  end
end
