require "msip/concerns/controllers/trivalentes_controller"

module Msip
  module Admin
    class TrivalentesController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::TrivalentesController
    end
  end
end
