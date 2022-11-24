require "msip/concerns/controllers/perfilesorgsocial_controller"

module Msip
  module Admin
    class PerfilesorgsocialController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::PerfilesorgsocialController
    end
  end
end
