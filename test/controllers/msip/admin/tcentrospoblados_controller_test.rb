# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class TcentrospobladosControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      if ENV["CONFIG_HOSTS"] != "www.example.com"
        raise "CONFIG_HOSTS debe ser www.example.com"
      end

      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
    end

    test "index: presenta plantilla de indice" do
      get admin_tcentrospoblados_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_tcentrospoblados_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_tcentrospoblados_url

      assert_template "msip/modelos/index"
    end

    test "show: muestra un registro" do
      tcentropoblado = Msip::Tcentropoblado.all.take
      get admin_tcentropoblado_url(tcentropoblado)

      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_tcentropoblado_url

      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      tcentropoblado = Msip::Tcentropoblado.all.take
      get edit_admin_tcentropoblado_url(tcentropoblado)

      assert_response :success
      assert_template :edit
    end

    test "post: crea un registro" do
      assert_difference("Msip::Tcentropoblado.count") do
        post admin_tcentrospoblados_url, params: { tcentropoblado: PRUEBA_TCENTROPOBLADO }
        # puts response.body
      end

      assert_redirected_to msip.admin_tcentropoblado_path(
        assigns(:tcentropoblado),
      )
    end

    test "post: redirige al registro creado" do
      post admin_tcentrospoblados_url, params: { tcentropoblado: PRUEBA_TCENTROPOBLADO }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_TCENTROPOBLADO.clone
      atc[:nombre] = ""
      post admin_tcentrospoblados_url, params: { tcentropoblado: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevotcentropoblado = Msip::Tcentropoblado.create!(PRUEBA_TCENTROPOBLADO)
      patch msip.admin_tcentropoblado_path(nuevotcentropoblado.id),
        params: {
          tcentropoblado: {
            id: nuevotcentropoblado.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_tcentropoblado_path(assigns(:tcentropoblado))
    end

    test "crear y eliminar" do
      assert_difference("Msip::Tcentropoblado.count") do
        post admin_tcentrospoblados_url, params: { tcentropoblado: PRUEBA_TCENTROPOBLADO }
        # puts response.body
      end

      assert_redirected_to msip.admin_tcentropoblado_path(
        assigns(:tcentropoblado),
      )
      idr = response.body.gsub(%r{.*tcentrospoblados/}, "").gsub(/">.*/, "")

      assert_difference("Tcentropoblado.count", -1) do
        delete msip.admin_tcentropoblado_path(Tcentropoblado.find(idr)) # Tcentropoblado sin centrospoblados
      end

      assert_redirected_to msip.admin_tcentrospoblados_path
    end
  end
end
