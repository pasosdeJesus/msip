# frozen_string_literal: true

require "msip/concerns/controllers/anexos_controller"

module Msip
  # Controlador de anexos
  class AnexosController < ApplicationController
    load_and_authorize_resource class: Msip::Anexo

    include Msip::Concerns::Controllers::AnexosController
  end
end
