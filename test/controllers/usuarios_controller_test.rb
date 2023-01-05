# frozen_string_literal: true

require_relative "../test_helper"

module Msip
  class UsuariosControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
    end

    test "should have a current_user" do
      assert @current_usuario
    end

    # Atributos mínimos para crear un usuario válido.
    ATRIBUTOS_VALIDOS = {
      nombre: "n",
      nusuario: "nusuario",
      email: "x@x.org",
      fechacreacion: "2014-1-1",
      encrypted_password: "x",
      created_at: "2014-11-11",
    }

    ATRIBUTOS_INVALIDOS = {
      nombre: "",
      nusuario: "",
      created_at: "2014-11-11",
    }

    test "index: asigna todos los usuarios como @usuarios" do
      #      if ::Usuario.where(nusuario: 'nusuario').count > 0
      #        usuario = ::Usuario.where(nusuario: 'nusuario').take
      #      else
      #        usuario = ::Usuario.create! ATRIBUTOS_VALIDOS
      #      end
      get usuarios_url

      assert_response :success
      assert_select "th", text: "Rol"
    end

    test "get show: asigna el usuario requerido como @usuario" do
      usuario = Usuario.create!(ATRIBUTOS_VALIDOS)
      get usuario_url(usuario)

      assert_response :success
      assert_select "dd", text: "nusuario"
    end

    test "new: asigna un nuevo usuario como @usuario" do
      get new_usuario_url

      assert_response :success
    end

    test "get edit: asigna el usuario requerido como @usuario" do
      usuario = Usuario.create!(ATRIBUTOS_VALIDOS)
      get edit_usuario_url(usuario)

      assert_response :success
      assert_template "edit"
      assert_select "form[action=?][method=?]",
        usuario_path(usuario),
        "post" do
        verifica_formulario_usuario
      end
    end

    test "post create: crea una Usuario" do
      assert_difference("::Usuario.count") do
        a = {
          nombre: "n",
          nusuario: "nusuario",
          email: "x@x.org",
          fechacreacion_localizada: "1/Ene/2014",
          password: "x",
          idioma: "es_CO",
          rol: 1,
          created_at: "2014-11-11",
        }
        post usuarios_url, params: { usuario: a }
        # puts @response.body
      end

      assert_redirected_to usuario_url(Usuario.last)
    end

    test "asigna el usuario recien creado como @usuario" do
      au = {
        nombre: "n",
        nusuario: "nusuario",
        email: "x@x.org",
        fechacreacion_localizada: "1/Ene/2014",
        password: "x",
        idioma: "es_CO",
        rol: 1,
        created_at: "2014-11-11",
      }
      post usuarios_url, params: { usuario: au }
      usuario = Usuario.where(nusuario: "nusuario").take

      assert usuario
    end

    test "redirige al usuario creado" do
      au = {
        nombre: "n",
        nusuario: "nusuario",
        email: "x@x.org",
        fechacreacion_localizada: "1/Ene/2014",
        password: "x",
        idioma: "es_CO",
        rol: 1,
        created_at: "2014-11-11",
      }
      post usuarios_url, params: { usuario: au }

      assert_redirected_to Usuario.last
    end

    test "vuelve a presentar la plantilla 'nueva'" do
      post usuarios_url, params: { usuario: ATRIBUTOS_INVALIDOS }

      assert_template "new"
      assert_select "form[action=?][method=?]", usuarios_path, "post" do
        verifica_formulario_usuario
      end
    end

    test "actualiza el usuario requerido" do
      usuario = Usuario.create!(ATRIBUTOS_VALIDOS)
      patch usuario_url(usuario), params: {
        usuario: {
          nombre: "nombreact2",
        },
      }

      assert_redirected_to usuario_url(usuario)
    end

    test "vuelve a presentar la plantilla 'editar'" do
      usuario = Usuario.create!(ATRIBUTOS_VALIDOS)
      patch usuario_url(usuario), params: { usuario: ATRIBUTOS_INVALIDOS }

      assert_template "edit"
    end

    test "elimina el usuario requerido" do
      usuario = if Usuario.where(nusuario: "nusuario").count > 0
        Usuario.where(nusuario: "nusuario").take
      else
        Usuario.create!(ATRIBUTOS_VALIDOS)
      end
      assert_difference("::Usuario.count", -1) do
        delete usuario_url(usuario)
      end
    end

    test "redirige a la lista de usuarios" do
      usuario = Usuario.create!(ATRIBUTOS_VALIDOS)
      delete usuario_url(usuario)

      assert_redirected_to usuarios_path
    end
  end
end
