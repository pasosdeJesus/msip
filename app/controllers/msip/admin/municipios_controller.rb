require "msip/concerns/controllers/municipios_controller"

module Msip
  module Admin
    class MunicipiosController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::MunicipiosController
    end
  end
end
