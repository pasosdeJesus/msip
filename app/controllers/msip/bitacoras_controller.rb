# frozen_string_literal: true

require "msip/concerns/controllers/bitacoras_controller"

module Msip
  class BitacorasController < Msip::ModelosController
    before_action :set_bitacora, only: [:show]
    load_and_authorize_resource class: Msip::Bitacora

    include Msip::Concerns::Controllers::BitacorasController
  end
end
