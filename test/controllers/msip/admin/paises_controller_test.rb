require_relative "../../../test_helper"
require_relative "../../../models/msip/pais_test"

module Msip
  class PaisesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup  do
      if ENV['CONFIG_HOSTS'] != 'www.example.com'
        raise 'CONFIG_HOSTS debe ser www.example.com'
      end
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
    end

    test "index: presenta plantilla de indice" do
      get admin_paises_url
      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get admin_paises_url, params: {term: 'x'}
      assert_response :success
      assert_template "index"
    end

    test "presenta plantilla admin/basicas/index" do
      get admin_paises_url
      assert_template "msip/modelos/index"
    end

    test "show: muestra un registro" do
      pais = Msip::Pais.all.take
      get admin_pais_url(pais)
      assert_response :success
      assert_template :show
    end

    test "new: formulario de nueva" do
      get new_admin_pais_url
      assert_response :success
      assert_template :new
    end

    test "edit: formulario de edición" do
      pais = Msip::Pais.all.take
      get edit_admin_pais_url(pais)
      assert_response :success
      assert_template :edit
    end

    test "post: crea un registro" do
      assert_difference('Msip::Pais.count') do
        post admin_paises_url, params: {pais: PRUEBA_PAIS}
        #puts response.body
      end
      assert_redirected_to msip.admin_pais_path(
        assigns(:pais)
      )
    end

    test "post: redirige al registro creado" do
      post admin_paises_url, params: { pais: PRUEBA_PAIS}
      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_PAIS.clone
      atc[:nombre] = ''
      post admin_paises_url, params: { pais: atc }
      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevopais = Msip::Pais.create!(PRUEBA_PAIS)
      patch msip.admin_pais_path(nuevopais.id),
        params: { 
          pais: { 
            id: nuevopais.id,
            nombre: 'xyz'
          }
        }

      assert_redirected_to msip.admin_pais_path(assigns(:pais))
    end

    test "debe eliminar" do
      assert_difference('Pais.count', -1) do
        delete msip.admin_pais_path(Pais.find(100)) # Pais sin deptos
      end

      assert_redirected_to msip.admin_paises_path
    end

  end
end
