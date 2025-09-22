# frozen_string_literal: true

require "msip/concerns/controllers/grupos_controller"

module Msip
  module Admin
    # Controlador de grupos.
    class GruposController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::GruposController
      load_and_authorize_resource class: Msip::Grupo
    end
  end
end
