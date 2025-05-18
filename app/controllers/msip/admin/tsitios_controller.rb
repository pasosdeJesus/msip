# frozen_string_literal: true

require "msip/concerns/controllers/tsitios_controller"

module Msip
  module Admin
    class TsitiosController < BasicasController
      before_action :set_tsitio, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tsitio

      include Msip::Concerns::Controllers::TsitiosController
    end
  end
end
