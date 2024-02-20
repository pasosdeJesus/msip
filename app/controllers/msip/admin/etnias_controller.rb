# frozen_string_literal: true

require "msip/concerns/controllers/etnias_controller"

module Msip
  module Admin
    class EtniasController < BasicasController

      before_action :set_etnia, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Etnia

      include Msip::Concerns::Controllers::EtniasController
    end
  end
end
