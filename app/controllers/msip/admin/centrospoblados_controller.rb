# frozen_string_literal: true

require "msip/concerns/controllers/centrospoblados_controller"

module Msip
  module Admin
    class CentrospobladosController < BasicasController
      before_action :set_centropoblado, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Centropoblado, except: [:tipo_centropoblado]

      include Msip::Concerns::Controllers::CentrospobladosController
    end
  end
end
