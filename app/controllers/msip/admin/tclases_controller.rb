# frozen_string_literal: true

require "msip/concerns/controllers/tclases_controller"

module Msip
  module Admin
    class TclasesController < BasicasController
      before_action :set_tclase, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Tclase

      include Msip::Concerns::Controllers::TclasesController

    end
  end
end
