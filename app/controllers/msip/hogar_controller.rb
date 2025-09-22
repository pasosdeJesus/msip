# frozen_string_literal: true

require "msip/concerns/controllers/hogar_controller"

module Msip
  # Controlador para la página de inicio y otras páginas públicas.
  class HogarController < ApplicationController
    # Sin chequeo de autorización porque son páginas iniciales para usuarios no
    # autenticados tambien
    include Msip::Concerns::Controllers::HogarController
  end
end
