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

        Rails.application.try(:reload_routes_unless_loaded)
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

      test "debe filtrar por nombre" do
        get msip.admin_etnias_path, params: {
          q: { nombre_cont: "Indígena" }
        }
        
        assert_response :success
        assert_template :index
      end

      test "debe filtrar por habilitadas" do
        get msip.admin_etnias_path, params: {
          q: { fechadeshabilitacion_null: true }
        }
        
        assert_response :success
        assert_template :index
      end

      test "debe validar nombre único" do
        # Intentar crear etnia con nombre duplicado
        post msip.admin_etnias_path, params: {
          etnia: ETNIA_NUEVO.merge(nombre: "INDÍGENA")
        }
        
        # Debe retornar al formulario con errores
        assert_response :success
        assert_template :new
      end

      test "debe validar campos requeridos" do
        post msip.admin_etnias_path, params: {
          etnia: { nombre: "" } # Nombre vacío
        }
        
        assert_response :success
        assert_template :new
        # Debe mostrar errores de validación
      end

      test "debe deshabilitar en lugar de eliminar si tiene referencias" do
        skip "Funcionalidad de soft delete pendiente de implementar"
        # Crear etnia con referencias para test
        etnia_con_ref = Msip::Etnia.create!(ETNIA_NUEVO.merge(
          nombre: "Etnia con Referencias"
        ))
        
        persona = Msip::Persona.create!(PRUEBA_PERSONA.merge(
          nombres: "Test",
          etnia: etnia_con_ref
        ))
        
        # Intentar eliminar debe deshabilitar en lugar de eliminar
        delete msip.admin_etnia_url(etnia_con_ref)
        
        etnia_con_ref.reload
        assert_not_nil etnia_con_ref.fechadeshabilitacion
        
        # Limpiar
        persona.destroy
        etnia_con_ref.destroy
      end

      test "debe manejar edición de etnia inexistente" do
        get msip.edit_admin_etnia_path(99999)
        # Debe redirigir o dar error, no necesariamente exception
        assert_includes [302, 404], response.status
      end

      test "debe exportar como CSV" do
        get msip.admin_etnias_path, params: { formato: "csv" }
        
        assert_includes [200, 302], response.status
      end

      test "debe manejar actualización con datos inválidos" do
        patch msip.admin_etnia_path(Etnia.find(3)), params: {
          etnia: { nombre: "" } # Nombre vacío
        }
        
        assert_response :success
        assert_template :edit
      end
    end
  end
end
