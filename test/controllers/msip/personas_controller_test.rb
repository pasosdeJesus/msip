# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class PersonasControllerTest < ActionDispatch::IntegrationTest
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
      get personas_url

      assert_response :success
      assert_template :index
    end

    test "presenta plantilla de indice filtradas por termino" do
      get personas_url, params: { "persona" => { "term" => "x" } }, as: :json

      assert_response :success
    end

    test "presenta plantilla admin/basicas/index" do
      get personas_url

      assert_template "msip/modelos/index"
    end

    test "new: formulario de nueva" do
      get new_persona_url

      assert_response :success
      assert_template :new
    end

    test "post: crea un registro" do
      assert_difference("Msip::Persona.count") do
        post personas_url, params: { persona: PRUEBA_PERSONA }
        # puts response.body
      end

      assert_redirected_to msip.persona_path(
        assigns(:persona),
      )
    end

    test "post: redirige al registro creado" do
      post personas_url, params: { persona: PRUEBA_PERSONA }

      assert_response :found
    end

    test "vuelve a plantilla nueva cuando hay errores de validación" do
      atc = PRUEBA_PERSONA.clone
      atc[:nombres] = ""
      post personas_url, params: { persona: atc }

      assert_template "new"
    end

    test "debe actualizar existente" do
      nuevopersona = Msip::Persona.create!(PRUEBA_PERSONA)
      patch msip.persona_path(nuevopersona.id),
        params: {
          persona: {
            id: nuevopersona.id,
            nombres: "xyz",
          },
        }

      assert_redirected_to msip.persona_path(assigns(:persona))
    end

    test "crear presentar editar eliminar" do
      ids1 = Msip::Persona.pluck(:id)
      assert_difference("Msip::Persona.count") do
        post personas_url, params: { persona: PRUEBA_PERSONA }
        # puts response.body
      end

      assert_redirected_to msip.persona_path(
        assigns(:persona),
      )
      ids2 = Msip::Persona.pluck(:id)
      idr = (ids2-ids1).first

      persona = Msip::Persona.all.take
      get persona_url(persona)

      assert_response :success
      assert_template :show

      get edit_persona_url(persona)

      assert_response :success
      assert_template :edit

      assert_difference("Persona.count", -1) do
        delete msip.persona_path(Persona.find(idr)) # Persona sin clases
      end

      assert_redirected_to msip.personas_path
    end
  end
end
