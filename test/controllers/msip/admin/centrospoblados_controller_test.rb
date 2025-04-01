# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class CentrospobladosControllerTest < ActionDispatch::IntegrationTest
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

    test "index: presenta plantilla de indice" do
      get admin_centrospoblados_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_centrospoblados_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get msip.admin_centrospoblados_url

      assert_template "msip/modelos/index"
    end

    test "show: muestra centropoblado" do
      centropoblado = Msip::Centropoblado.all.take
      get admin_centropoblado_url(centropoblado)

      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_centropoblado_url

      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      centropoblado = Msip::Centropoblado.all.take
      get edit_admin_centropoblado_url(centropoblado)

      assert_response :success
      assert_template :edit
    end

    test "post: crea un centropoblado 1" do
      assert_difference("Msip::Centropoblado.count") do
        post admin_centrospoblados_url, params: { centropoblado: PRUEBA_CENTROPOBLADO }
        # puts response.body
      end

      assert_redirected_to msip.admin_centropoblado_path(
        assigns(:centropoblado),
      )
    end

    test "post: redirige al centropoblado creado" do
      post admin_centrospoblados_url, params: { centropoblado: PRUEBA_CENTROPOBLADO }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_CENTROPOBLADO.clone
      atc[:nombre] = ""
      post admin_centrospoblados_url, params: { centropoblado: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevacentropoblado = Msip::Centropoblado.create!(PRUEBA_CENTROPOBLADO)
      patch msip.admin_centropoblado_path(nuevacentropoblado.id),
        params: {
          centropoblado: {
            id: nuevacentropoblado.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_centropoblado_path(assigns(:centropoblado))
    end

    test "debe eliminar" do
      assert_difference("Centropoblado.count", -1) do
        Msip::Ubicacionpre.where(centropoblado_id: 1).delete_all
        delete msip.admin_centropoblado_path(Centropoblado.find(1))
      end

      assert_redirected_to msip.admin_centrospoblados_path
    end
  end
end
