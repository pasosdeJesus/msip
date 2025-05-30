# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class OficinasControllerTest < ActionDispatch::IntegrationTest
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
      get admin_oficinas_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_oficinas_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_oficinas_url

      assert_template "msip/modelos/index"
    end

    test "show: muestra un registro" do
      oficina = Msip::Oficina.all.take
      get admin_oficina_url(oficina)

      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_oficina_url

      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      oficina = Msip::Oficina.all.take
      get edit_admin_oficina_url(oficina)

      assert_response :success
      assert_template :edit
    end

    test "post: crea un registro" do
      assert_difference("Msip::Oficina.count") do
        post admin_oficinas_url, params: { oficina: PRUEBA_OFICINA }
        # puts response.body
      end

      assert_redirected_to msip.admin_oficina_path(
        assigns(:oficina),
      )
    end

    test "post: redirige al registro creado" do
      post admin_oficinas_url, params: { oficina: PRUEBA_OFICINA }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_OFICINA.clone
      atc[:nombre] = ""
      post admin_oficinas_url, params: { oficina: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevooficina = Msip::Oficina.create!(PRUEBA_OFICINA)
      patch msip.admin_oficina_path(nuevooficina.id),
        params: {
          oficina: {
            id: nuevooficina.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_oficina_path(assigns(:oficina))
    end

    test "crear y eliminar" do
      ids1 = Msip::Oficina.pluck(:id)
      assert_difference("Msip::Oficina.count") do
        post admin_oficinas_url, params: { oficina: PRUEBA_OFICINA }
        # puts response.body
      end

      assert_redirected_to msip.admin_oficina_path(
        assigns(:oficina),
      )
      ids2 = Msip::Oficina.pluck(:id)
      idof = (ids2 - ids1).first

      assert_difference("Oficina.count", -1) do
        delete msip.admin_oficina_path(Oficina.find(idof))
      end

      assert_redirected_to msip.admin_oficinas_path
    end
  end
end
