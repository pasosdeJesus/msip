# frozen_string_literal: true

require "msip/concerns/controllers/temas_controller"

module Msip
  module Admin
    class TemasController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::TemasController
    end
  end
end
