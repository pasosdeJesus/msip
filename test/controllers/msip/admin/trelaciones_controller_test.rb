# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class TrelacionesControllerTest < ActionDispatch::IntegrationTest
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
      get admin_trelaciones_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_trelaciones_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_trelaciones_url

      assert_template "msip/modelos/index"
    end

    test "show: muestra un registro" do
      trelacion = Msip::Trelacion.all.take
      get admin_trelacion_url(trelacion)

      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_trelacion_url

      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      trelacion = Msip::Trelacion.all.take
      get edit_admin_trelacion_url(trelacion)

      assert_response :success
      assert_template :edit
    end

    test "post: crea un registro" do
      assert_difference("Msip::Trelacion.count") do
        post admin_trelaciones_url, params: { trelacion: PRUEBA_TRELACION }
        # puts response.body
      end

      assert_redirected_to msip.admin_trelacion_path(
        assigns(:trelacion),
      )
    end

    test "post: redirige al registro creado" do
      post admin_trelaciones_url, params: { trelacion: PRUEBA_TRELACION }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_TRELACION.clone
      atc[:nombre] = ""
      post admin_trelaciones_url, params: { trelacion: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevotrelacion = Msip::Trelacion.create!(PRUEBA_TRELACION)
      patch msip.admin_trelacion_path(nuevotrelacion.id),
        params: {
          trelacion: {
            id: nuevotrelacion.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_trelacion_path(assigns(:trelacion))
    end

    test "crear y eliminar" do
      ids1 = Msip::Trelacion.pluck(:id)
      assert_difference("Msip::Trelacion.count") do
        post admin_trelaciones_url, params: { trelacion: PRUEBA_TRELACION }
        # puts response.body
      end

      assert_redirected_to msip.admin_trelacion_path(
        assigns(:trelacion),
      )
      ids2 = Msip::Trelacion.pluck(:id)
      idr = (ids2 - ids1).first

      assert_difference("Trelacion.count", -1) do
        delete msip.admin_trelacion_path(Trelacion.find(idr))
      end

      assert_redirected_to msip.admin_trelaciones_path
    end
  end
end
