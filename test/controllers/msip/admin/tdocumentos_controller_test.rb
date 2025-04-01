# frozen_string_literal: true

require "test_helper"

module Msip
  module Admin
    class TdocumentosControllerTest < ActionDispatch::IntegrationTest
      TDOCUMENTO_NUEVO = {
        created_at: "2021-07-29",
        fechacreacion: "2021-07-29",
        fechadeshabilitacion: nil,
        nombre: "X",
        sigla: "X",
        observaciones: "y",
        updated_at: "2021-07-18",
      }

      include Rails.application.routes.url_helpers
      include Devise::Test::IntegrationHelpers

      setup do
        if ENV["CONFIG_HOSTS"] != "www.example.com"
          raise "CONFIG_HOSTS debe ser www.example.com"
        end

        Rails.application.try(:reload_routes_unless_loaded)
        @current_usuario = ::Usuario.find(1)
        sign_in @current_usuario
      end

      # Cada prueba se ejecuta se hace en una transacción
      # que después de la prueba se revierte

      test "debe presentar listado" do
        get msip.admin_tdocumentos_path

        assert_response :success
        assert_template :index
      end

      test "debe presentar resumen de existente" do
        get msip.admin_tdocumento_url(Tdocumento.find(1))

        assert_response :success
        assert_template :show
      end

      test "debe presentar formulario para nueva" do
        get msip.new_admin_tdocumento_path

        assert_response :success
        assert_template :new
      end

      test "debe crear nueva" do
        assert_difference("Tdocumento.count") do
          post msip.admin_tdocumentos_path, params: {
            tdocumento: TDOCUMENTO_NUEVO,
          }
        end

        assert_redirected_to msip.admin_tdocumento_path(
          assigns(:tdocumento),
        )
      end

      test "debe actualizar existente" do
        patch msip.admin_tdocumento_path(Tdocumento.find(1)),
          params: { tdocumento: { nombre: "YY" } }

        assert_redirected_to msip.admin_tdocumento_path(
          assigns(:tdocumento),
        )
      end

      test "debe eliminar" do
        assert_difference("Tdocumento.count", -1) do
          delete msip.admin_tdocumento_url(Tdocumento.find(1))
        end

        assert_redirected_to msip.admin_tdocumentos_path
      end
    end
  end
end
