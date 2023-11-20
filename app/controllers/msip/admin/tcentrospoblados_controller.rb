# frozen_string_literal: true

require "msip/concerns/controllers/tcentrospoblados_controller"

module Msip
  module Admin
    class TcentrospobladosController < BasicasController
      before_action :set_tcentropoblado, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tcentropoblado

      include Msip::Concerns::Controllers::TcentrospobladosController

    end
  end
end
