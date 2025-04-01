# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class UbicacionesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      if ENV["CONFIG_HOSTS"] != "www.example.com"
        raise "CONFIG_HOSTS debe ser www.example.com"
      end

      Rails.application.try(:reload_routes_unless_loaded)
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
    end

    test "nuevo: crea una nueva" do
      skip # Por arreglar en mmsip cuando en ubicaciones_controller no se requiera id_caso
      get nueva_ubicacion_url

      assert_response :success
      assert_template :new
    end
  end
end
