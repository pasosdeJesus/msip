# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class TsitiosControllerTest < ActionDispatch::IntegrationTest
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
      get admin_tsitios_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_tsitios_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_tsitios_url

      assert_template "msip/modelos/index"
    end

    test "show: muestra un registro" do
      tsitio = Msip::Tsitio.all.take
      get admin_tsitio_url(tsitio)

      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_tsitio_url

      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      tsitio = Msip::Tsitio.all.take
      get edit_admin_tsitio_url(tsitio)

      assert_response :success
      assert_template :edit
    end

    test "post: crea un registro" do
      assert_difference("Msip::Tsitio.count") do
        post admin_tsitios_url, params: { tsitio: PRUEBA_TSITIO }
        # puts response.body
      end

      assert_redirected_to msip.admin_tsitio_path(
        assigns(:tsitio),
      )
    end

    test "post: redirige al registro creado" do
      post admin_tsitios_url, params: { tsitio: PRUEBA_TSITIO }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_TSITIO.clone
      atc[:nombre] = ""
      post admin_tsitios_url, params: { tsitio: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevotsitio = Msip::Tsitio.create!(PRUEBA_TSITIO)
      patch msip.admin_tsitio_path(nuevotsitio.id),
        params: {
          tsitio: {
            id: nuevotsitio.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_tsitio_path(assigns(:tsitio))
    end

    test "crear y eliminar" do
      ids1 = Msip::Tsitio.pluck(:id)
      assert_difference("Msip::Tsitio.count") do
        post admin_tsitios_url, params: { tsitio: PRUEBA_TSITIO }
        # puts response.body
      end

      assert_redirected_to msip.admin_tsitio_path(
        assigns(:tsitio),
      )
      ids2 = Msip::Tsitio.pluck(:id)
      idof = (ids2 - ids1).first

      assert_difference("Tsitio.count", -1) do
        delete msip.admin_tsitio_path(Tsitio.find(idof))
      end

      assert_redirected_to msip.admin_tsitios_path
    end
  end
end
