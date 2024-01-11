# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class PerfilesorgsocialControllerTest < ActionDispatch::IntegrationTest
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
      get admin_perfilesorgsocial_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_perfilesorgsocial_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_perfilesorgsocial_url

      assert_template "msip/modelos/index"
    end

    test "new: formulario de nueva" do
      get new_admin_perfilorgsocial_url

      assert_response :success
      assert_template :new
    end

    test "post: crea un registro" do
      assert_difference("Msip::Perfilorgsocial.count") do
        post admin_perfilesorgsocial_url, params: { perfilorgsocial: PRUEBA_PERFILORGSOCIAL }
        # puts response.body
      end

      assert_redirected_to msip.admin_perfilorgsocial_path(
        assigns(:perfilorgsocial),
      )
    end

    test "post: redirige al registro creado" do
      post admin_perfilesorgsocial_url, params: { perfilorgsocial: PRUEBA_PERFILORGSOCIAL }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_PERFILORGSOCIAL.clone
      atc[:nombre] = ""
      post admin_perfilesorgsocial_url, params: { perfilorgsocial: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevoperfilorgsocial = Msip::Perfilorgsocial.create!(PRUEBA_PERFILORGSOCIAL)
      patch msip.admin_perfilorgsocial_path(nuevoperfilorgsocial.id),
        params: {
          perfilorgsocial: {
            id: nuevoperfilorgsocial.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_perfilorgsocial_path(assigns(:perfilorgsocial))
    end

    test "crear presentar editar eliminar" do
      ids1 = Msip::Perfilorgsocial.pluck(:id)
      assert_difference("Msip::Perfilorgsocial.count") do
        post admin_perfilesorgsocial_url, params: { perfilorgsocial: PRUEBA_PERFILORGSOCIAL }
        # puts response.body
      end

      assert_redirected_to msip.admin_perfilorgsocial_path(
        assigns(:perfilorgsocial),
      )
      ids2 = Msip::Perfilorgsocial.pluck(:id)
      idr = (ids2-ids1).first

      perfilorgsocial = Msip::Perfilorgsocial.all.take
      get admin_perfilorgsocial_url(perfilorgsocial)

      assert_response :success
      assert_template :show

      get edit_admin_perfilorgsocial_url(perfilorgsocial)

      assert_response :success
      assert_template :edit

      assert_difference("Perfilorgsocial.count", -1) do
        delete msip.admin_perfilorgsocial_path(Perfilorgsocial.find(idr))
      end

      assert_redirected_to msip.admin_perfilesorgsocial_path
    end
  end
end
