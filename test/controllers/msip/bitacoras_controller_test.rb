# frozen_string_literal: true

require "test_helper"

module Msip
  class BitacorasControllerTest < ActionDispatch::IntegrationTest
    include Rails.application.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    # include Cocoon::ViewHelpers

    setup do
      if ENV["CONFIG_HOSTS"] != "www.example.com"
        raise "CONFIG_HOSTS debe ser www.example.com"
      end

      @current_usuario = ::Usuario.find(1)
      sign_in @current_usuario
      @bitacora = Msip::Bitacora.create!(PRUEBA_BITACORA)
    end

    # Cada prueba que se ejecuta se hace en una transacción
    # que después de la prueba se revierte

    test "debe presentar listado" do
      get msip.bitacoras_path

      assert_response :success
      assert_template :index
    end

    test "debe presentar resumen de existente" do
      get msip.bitacora_url(@bitacora.id)

      assert_response :success
      assert_template :show
    end

    test "debe presentar formulario para nueva" do
      skip # no debe existir arreglar en mmsip
      get msip.new_bitacora_path

      assert_response :success
      assert_template :new
    end

    test "debe presentar formulario de edición" do
      skip # no debe existir arreglar en mmsip
      get msip.edit_bitacora_path(@bitacora)

      assert_response :success
      assert_template :edit
    end

    test "debe crear nueva" do
      skip # no debe existir arreglar en mmsip
    end

    test "debe actualizar existente" do
      skip # no debe existir arreglar en mmsip
      patch msip.bitacora_path(@bitacora.id),
        params: {
          bitacora: {
            id: @bitacora.id,
          },
        }

      assert_redirected_to msip.bitacora_path(assigns(:bitacora))
    end

    test "debe eliminar" do
      skip # no debe existir arreglar en mmsip
      assert_difference("Bitacora.count", -1) do
        delete msip.bitacora_path(Bitacora.find(1))
      end

      assert_redirected_to msip.bitacoras_path
    end
  end
end
