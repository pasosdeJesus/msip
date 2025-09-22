# frozen_string_literal: true

require "msip/concerns/controllers/perfilesorgsocial_controller"

module Msip
  module Admin
    # Controlador de perfiles de organización social.
    class PerfilesorgsocialController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::PerfilesorgsocialController
    end
  end
end
