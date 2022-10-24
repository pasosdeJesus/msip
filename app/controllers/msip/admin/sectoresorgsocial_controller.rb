
require 'msip/concerns/controllers/sectoresorgsocial_controller'

module Msip
  module Admin
    class SectoresorgsocialController < Msip::Admin::BasicasController
      include Msip::Concerns::Controllers::SectoresorgsocialController
      load_and_authorize_resource class: Msip::Sectororgsocial
    end
  end
end
