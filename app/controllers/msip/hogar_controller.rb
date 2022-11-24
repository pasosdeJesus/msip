require "msip/concerns/controllers/hogar_controller"

module Msip
  class HogarController < ApplicationController
    # Sin chequeo de autorización porque son páginas iniciales para usuarios no
    # autenticados tambien
    include Msip::Concerns::Controllers::HogarController
  end
end
