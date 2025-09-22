# frozen_string_literal: true

require "msip/concerns/controllers/veredas_controller"

module Msip
  module Admin
    # Controlador de veredas.
    class VeredasController < Msip::Admin::BasicasController
      before_action :set_vereda,
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Vereda

      include Msip::Concerns::Controllers::VeredasController
    end
  end
end
