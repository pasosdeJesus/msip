require "msip/concerns/controllers/gruposper_controller"

module Msip
  class GruposperController < ApplicationController
    load_and_authorize_resource class: Msip::Grupoper
    include Msip::Concerns::Controllers::GruposperController
  end
end
