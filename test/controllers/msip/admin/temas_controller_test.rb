# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class TemasControllerTest < ActionDispatch::IntegrationTest
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
      get admin_temas_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_temas_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_temas_url

      assert_template "msip/modelos/index"
    end

    test "show: muestra un registro" do
      tema = Msip::Tema.all.take
      get admin_tema_url(tema)

      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_tema_url

      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      tema = Msip::Tema.all.take
      get edit_admin_tema_url(tema)

      assert_response :success
      assert_template :edit
    end

    test "post: crea un registro" do
      assert_difference("Msip::Tema.count") do
        post admin_temas_url, params: { tema: PRUEBA_TEMA }
        # puts response.body
      end

      assert_redirected_to msip.admin_tema_path(
        assigns(:tema),
      )
    end

    test "post: redirige al registro creado" do
      post admin_temas_url, params: { tema: PRUEBA_TEMA }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_TEMA.clone
      atc[:nombre] = ""
      post admin_temas_url, params: { tema: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevotema = Msip::Tema.create!(PRUEBA_TEMA)
      patch msip.admin_tema_path(nuevotema.id),
        params: {
          tema: {
            id: nuevotema.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_tema_path(assigns(:tema))
    end

    test "crear y eliminar" do
      ids1 = Msip::Tema.pluck(:id)
      assert_difference("Msip::Tema.count") do
        post admin_temas_url, params: { tema: PRUEBA_TEMA }
        # puts response.body
      end

      assert_redirected_to msip.admin_tema_path(
        assigns(:tema),
      )
      ids2 = Msip::Tema.pluck(:id)
      idof = (ids2-ids1).first

      assert_difference("Tema.count", -1) do
        delete msip.admin_tema_path(Tema.find(idof)) # Tema sin clases
      end

      assert_redirected_to msip.admin_temas_path
    end
  end
end
