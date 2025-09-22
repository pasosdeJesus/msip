# frozen_string_literal: true

require "msip/concerns/controllers/oficinas_controller"

module Msip
  module Admin
    # Controlador de oficinas.
    class OficinasController < Msip::Admin::BasicasController
      before_action :set_oficina,
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Oficina

      include Msip::Concerns::Controllers::OficinasController
    end
  end
end
