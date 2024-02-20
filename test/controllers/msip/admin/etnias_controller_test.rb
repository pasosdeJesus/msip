# frozen_string_literal: true

require "test_helper"

module Msip
  module Admin
    class EtniasControllerTest < ActionDispatch::IntegrationTest
      ETNIA_NUEVO = {
        created_at: "2024-02-19",
        fechacreacion: "2024-02-19",
        fechadeshabilitacion: nil,
        nombre: "X",
        observaciones: "y",
        descripcion: "d",
        updated_at: "2021-07-18",
      }

      include Rails.application.routes.url_helpers
      include Devise::Test::IntegrationHelpers

      setup do
        if ENV["CONFIG_HOSTS"] != "www.example.com"
          raise "CONFIG_HOSTS debe ser www.example.com"
        end

        @current_usuario = ::Usuario.find(1)
        sign_in @current_usuario
      end

      # Cada prueba se ejecuta se hace en una transacción
      # que después de la prueba se revierte

      test "debe presentar listado" do
        get msip.admin_etnias_path

        assert_response :success
        assert_template :index
      end

      test "debe presentar resumen de existente" do
        get msip.admin_etnia_url(Etnia.find(1))

        assert_response :success
        assert_template :show
      end

      test "debe presentar formulario para nueva" do
        get msip.new_admin_etnia_path

        assert_response :success
        assert_template :new
      end

      test "debe crear nueva" do
        assert_difference("Etnia.count") do
          post msip.admin_etnias_path, params: {
            etnia: ETNIA_NUEVO,
          }
        end

        assert_redirected_to msip.admin_etnia_path(
          assigns(:etnia),
        )
      end

      test "debe actualizar existente" do
        patch msip.admin_etnia_path(Etnia.find(3)),
          params: { etnia: { nombre: "YY" } }

        assert_redirected_to msip.admin_etnia_path(
          assigns(:etnia),
        )
      end

      test "debe eliminar" do
        assert_difference("Etnia.count", -1) do
          delete msip.admin_etnia_url(Etnia.find(1))
        end

        assert_redirected_to msip.admin_etnias_path
      end
    end
  end
end
