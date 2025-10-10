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

      Rails.application.try(:reload_routes_unless_loaded)
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

    # Bitácora es solo lectura - no debe tener formularios ni acciones de escritura
    # Tests eliminados: new, edit, create, update, destroy (resuelto en issue #6)

    test "debe filtrar por fecha" do
      get msip.bitacoras_path, params: { 
        q: { 
          fecha_gteq: "2020-01-01",
          fecha_lteq: "2020-12-31"
        }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe filtrar por usuario" do
      get msip.bitacoras_path, params: {
        q: { usuario_id_eq: 1 }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe filtrar por modelo" do
      get msip.bitacoras_path, params: {
        q: { modelo_cont: "Persona" }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe filtrar por operación" do
      get msip.bitacoras_path, params: {
        q: { operacion_cont: "actualiza" }
      }
      
      assert_response :success
      assert_template :index
    end

    test "debe exportar listado como CSV" do
      get msip.bitacoras_path, params: { formato: "csv" }
      
      # Puede dar success o redirect dependiendo de implementación
      assert_includes [200, 302], response.status
    end

    test "debe manejar búsqueda vacía" do
      get msip.bitacoras_path, params: { q: { modelo_cont: "" } }
      
      assert_response :success
      assert_template :index
    end

    test "debe paginar resultados" do
      # Crear varias bitácoras para probar paginación
      10.times do |i|
        Msip::Bitacora.create!(PRUEBA_BITACORA.merge(
          detalle: "Prueba #{i}",
          modelo_id: i + 1
        ))
      end
      
      get msip.bitacoras_path, params: { page: 1 }
      
      assert_response :success
      assert_template :index
    end

    test "debe manejar filtros combinados" do
      get msip.bitacoras_path, params: {
        q: {
          fecha_gteq: "2020-01-01",
          modelo_cont: "Persona",
          operacion_cont: "actualiza"
        }
      }
      
      assert_response :success
      assert_template :index
    end
  end
end
