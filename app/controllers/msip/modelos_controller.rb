# frozen_string_literal: true

require "msip/concerns/controllers/modelos_controller"

module Msip
  class ModelosController < ApplicationController
    # Sin chequeo de autorización porque es utilidad para
    # otros controladores
    include Msip::Concerns::Controllers::ModelosController
  end
end
