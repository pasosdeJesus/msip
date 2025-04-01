# frozen_string_literal: true

require "test_helper"

module Msip
  module Admin
    class GruposControllerTest < ActionDispatch::IntegrationTest
      GRUPO_NUEVO = {
        created_at: "2021-07-29",
        fechacreacion: "2021-07-29",
        fechadeshabilitacion: nil,
        nombre: "X",
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
        get msip.admin_grupos_path

        assert_response :success
        assert_template :index
      end

      test "debe presentar resumen de existente" do
        g = Msip::Grupo.create!(GRUPO_NUEVO)
        get msip.admin_grupo_url(Grupo.find(g.id))

        assert_response :success
        assert_template :show
      end

      test "debe presentar formulario para nueva" do
        get msip.new_admin_grupo_path

        assert_response :success
        assert_template :new
      end

      test "debe crear nueva" do
        assert_difference("Grupo.count") do
          post msip.admin_grupos_path, params: {
            grupo: GRUPO_NUEVO,
          }
        end

        assert_redirected_to msip.admin_grupo_path(
          assigns(:grupo),
        )
      end

      test "debe actualizar existente" do
        g = Msip::Grupo.create!(GRUPO_NUEVO)
        patch msip.admin_grupo_path(Grupo.find(g.id)),
          params: { grupo: { nombre: "YY" } }

        assert_redirected_to msip.admin_grupo_path(
          assigns(:grupo),
        )
      end

      test "debe eliminar" do
        g = Msip::Grupo.create!(GRUPO_NUEVO)
        assert_difference("Grupo.count", -1) do
          delete msip.admin_grupo_url(Grupo.find(g.id))
        end

        assert_redirected_to msip.admin_grupos_path
      end
    end
  end
end
