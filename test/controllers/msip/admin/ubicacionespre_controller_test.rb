# frozen_string_literal: true

require "test_helper"

module Msip
  module Admin
    class UbicacionespreControllerTest < ActionDispatch::IntegrationTest
      include Rails.application.routes.url_helpers
      include Devise::Test::IntegrationHelpers

      setup do
        if ENV["CONFIG_HOSTS"] != "www.example.com"
          raise "CONFIG_HOSTS debe ser www.example.com"
        end

        Rails.application.try(:reload_routes_unless_loaded)
        @current_usuario = ::Usuario.find(1)
        sign_in @current_usuario
        @ubicacionpre = Msip::Ubicacionpre.create!(PRUEBA_UBICACIONPRE)
      end

      # Cada prueba que se ejecuta se hace en una transacción
      # que después de la prueba se revierte

      test "debe presentar listado" do
        get msip.admin_ubicacionespre_path

        assert_response :success
        assert_template :index
      end

      test "listado json" do
        skip # Agota memoria
        get msip.admin_ubicacionespre_path + "ubicacionpre", as: :json

        assert_response :success
      end

      test "listado json con term" do
        get msip.admin_ubicacionespre_path + "?ubicacionpre[term]=buen", as: :json

        assert_response :success
      end

      test "debe presentar resumen de existente" do
        get msip.admin_ubicacionpre_path(@ubicacionpre.id)

        assert_response :success
        assert_template :show
      end

      test "debe presentar formulario para nueva" do
        get msip.new_admin_ubicacionpre_path

        assert_response :success
        assert_template :new
      end

      test "debe presentar formulario de edición" do
        get msip.edit_admin_ubicacionpre_path(@ubicacionpre)

        assert_response :success
        assert_template :edit
      end

      test "debe crear nueva" do
        # Arreglamos indice
        Msip::Ubicacionpre.connection.execute(<<-SQL.squish)
        SELECT setval('public.msip_ubicacionpre_id_seq', MAX(id))#{" "}
          FROM public.msip_ubicacionpre;
        SQL
        assert_difference("Ubicacionpre.count") do
          post msip.admin_ubicacionespre_path, params: {
            ubicacionpre: {
              id: nil,
              pais_id: 100,
              lugar: "IMAGINA2",
              nombre: "IMAGINA2 / BULGARIA",
              nombre_sin_pais: "IMAGINA2",
            },
          }
        end

        assert_redirected_to msip.admin_ubicacionpre_path(
          assigns(:ubicacionpre),
        )
      end

      test "debe actualizar existente" do
        patch msip.admin_ubicacionpre_path(@ubicacionpre.id),
          params: {
            ubicacionpre: {
              id: @ubicacionpre.id,
              nombre: "IMAGINA3 / BULGARIA",
            },
          }

        assert_redirected_to msip.admin_ubicacionpre_path(assigns(:ubicacionpre))
      end

      test "debe eliminar" do
        assert_difference("Ubicacionpre.count", -1) do
          delete msip.admin_ubicacionpre_path(@ubicacionpre.id)
        end

        assert_redirected_to msip.admin_ubicacionespre_path
      end
    end
  end
end
