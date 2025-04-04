# frozen_string_literal: true

require_relative "../../../test_helper"

module Msip
  class VeredasControllerTest < ActionDispatch::IntegrationTest
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
      get admin_veredas_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_veredas_url, params: { term: "x" }

      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_veredas_url

      assert_template "msip/modelos/index"
    end

    test "show: muestra un registro" do
      vereda = Msip::Vereda.all.take
      get admin_vereda_url(vereda)

      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_vereda_url

      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      vereda = Msip::Vereda.all.take
      get edit_admin_vereda_url(vereda)

      assert_response :success
      assert_template :edit
    end

    test "post: crea un registro" do
      assert_difference("Msip::Vereda.count") do
        post admin_veredas_url, params: { vereda: PRUEBA_VEREDA }
        # puts response.body
      end

      assert_redirected_to msip.admin_vereda_path(
        assigns(:vereda),
      )
    end

    test "post: redirige al registro creado" do
      post admin_veredas_url, params: { vereda: PRUEBA_VEREDA }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_VEREDA.clone
      atc[:nombre] = ""
      post admin_veredas_url, params: { vereda: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevovereda = Msip::Vereda.create!(PRUEBA_VEREDA)
      patch msip.admin_vereda_path(nuevovereda.id),
        params: {
          vereda: {
            id: nuevovereda.id,
            nombre: "xyz",
          },
        }

      assert_redirected_to msip.admin_vereda_path(assigns(:vereda))
    end

    test "debe eliminar" do
      assert_difference("Vereda.count", -1) do
        Msip::Ubicacionpre.where(vereda_id: 323).delete_all
        delete msip.admin_vereda_path(Vereda.find(323))
      end

      assert_redirected_to msip.admin_veredas_path
    end
  end
end
