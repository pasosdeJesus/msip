# frozen_string_literal: true

require "msip/concerns/controllers/clases_controller"

module Msip
  module Admin
    class ClasesController < BasicasController
      before_action :set_clase, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Clase, except: [:tipo_clase]

      include Msip::Concerns::Controllers::ClasesController
    end
  end
end
