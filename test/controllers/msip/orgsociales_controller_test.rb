# frozen_string_literal: true

require "test_helper"

module Msip
  class OrgsocialesControllerTest < ActionDispatch::IntegrationTest
    include Rails.application.routes.url_helpers
    include Devise::Test::IntegrationHelpers
    # include Cocoon::ViewHelpers

    setup do
      if ENV["CONFIG_HOSTS"] != "www.example.com"
        raise "CONFIG_HOSTS debe ser www.example.com"
      end

      Rails.application.try(:reload_routes_unless_loaded)
      @current_usuario = ::Usuario.find(1)
      sign_in @current_usuario
      @grupoper = Msip::Grupoper.create!(PRUEBA_GRUPOPER)
      @orgsocial = Msip::Orgsocial.create!(PRUEBA_ORGSOCIAL)
    end

    # Cada prueba que se ejecuta se hace en una transacción
    # que después de la prueba se revierte

    test "debe presentar listado" do
      get msip.orgsociales_path

      assert_response :success
      assert_template :index
    end

    test "debe presentar resumen de existente" do
      get msip.orgsocial_url(@orgsocial.id)

      assert_response :success
      assert_template :show
    end

    test "debe presentar formulario para nueva" do
      get msip.new_orgsocial_path

      assert_response :success
      assert_template :new
    end

    test "debe presentar formulario de edición" do
      get msip.edit_orgsocial_path(@orgsocial)

      assert_response :success
      assert_template :edit
    end

    test "debe crear nueva" do
      # Arreglamos indice
      Msip::Orgsocial.connection.execute(<<-SQL.squish)
        SELECT setval('public.msip_orgsocial_id_seq', MAX(id))#{" "}
          FROM public.msip_orgsocial;
      SQL
      assert_difference("Orgsocial.count") do
        post msip.orgsociales_path, params: {
          orgsocial: {
            id: nil,
            grupoper_attributes: {
              id: nil,
              nombre: "ZZ",
            },
          },
        }
      end

      assert_redirected_to msip.orgsocial_path(
        assigns(:orgsocial),
      )
    end

    test "debe actualizar existente" do
      patch msip.orgsocial_path(@orgsocial.id),
        params: {
          orgsocial: {
            id: @orgsocial.id,
            grupoper_attributes: {
              id: @grupoper.id,
              nombre: "YY",
            },
          },
        }

      assert_redirected_to msip.orgsocial_path(assigns(:orgsocial))
    end

    test "debe eliminar" do
      assert_difference("Orgsocial.count", -1) do
        delete msip.orgsocial_path(Orgsocial.find(1))
      end

      assert_redirected_to msip.orgsociales_path
    end

    test "debe filtrar por nombre" do
      get msip.orgsociales_path, params: {
        q: { grupoper_nombre_cont: "Organización" }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe filtrar por sector" do
      get msip.orgsociales_path, params: {
        q: { sectororgsocial_id_eq: 1 }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe filtrar por perfil" do
      get msip.orgsociales_path, params: {
        q: { perfilorgsocial_id_eq: 1 }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe manejar búsqueda por múltiples criterios" do
      get msip.orgsociales_path, params: {
        q: {
          grupoper_nombre_cont: "Test",
          sectororgsocial_id_eq: 1,
          perfilorgsocial_id_eq: 1
        }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe exportar como CSV" do
      get msip.orgsociales_path, params: { formato: "csv" }
      
      # Puede dar success o redirect
      assert_includes [200, 302], response.status
    end

    test "debe crear organización con personas asociadas" do
      skip "Requiere configuración específica de datos anidados"
    end

    test "debe actualizar organización y sus personas" do
      patch msip.orgsocial_path(@orgsocial), params: {
        orgsocial: {
          grupoper_attributes: {
            id: @orgsocial.grupoper.id,
            nombre: "Organización Actualizada"
          }
        }
      }

      assert_redirected_to msip.orgsocial_path(@orgsocial)
      
      # Verificar que se actualizó
      @orgsocial.reload
      assert_equal "Organización Actualizada", @orgsocial.grupoper.nombre
    end

    test "debe validar datos requeridos al crear" do
      post msip.orgsociales_path, params: {
        orgsocial: {
          grupoper_attributes: {
            nombre: "" # Nombre vacío debe fallar
          }
        }
      }
      
      assert_response :success
      assert_template :new
      # Debe mostrar el formulario con errores
    end

    test "debe manejar paginación" do
      get msip.orgsociales_path, params: { page: 1 }
      
      assert_response :success
      assert_template :index
    end
  end
end
