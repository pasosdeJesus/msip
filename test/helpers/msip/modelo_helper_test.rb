# frozen_string_literal: true

require "test_helper"

module Msip
  class ModeloHelperTest < ActionView::TestCase
    include Msip::ModeloHelper

    test "nombreobj con modelo simple" do
      persona = Msip::Persona.new
      resultado = nombreobj(persona)
      # El resultado puede estar en minúsculas
      assert_includes ["Persona", "persona"], resultado
    end

    test "nombreobj con plural" do
      persona = Msip::Persona.new
      resultado = nombreobj(persona, true)
      # El resultado puede estar en minúsculas
      assert_includes ["Personas", "personas"], resultado
    end

    test "meses constante" do
      assert_equal 12, MESES.length
      assert_includes MESES.first, "ENERO"
      assert_includes MESES.first, 1
    end

    test "nosi constante" do
      assert_equal 3, NOSI.length
      assert_includes NOSI, [:NO, :N]
      assert_includes NOSI, [:SI, :S]
    end

    test "ruta_responde_0p con ruta inexistente" do
      resultado = ruta_responde_0p("ruta_inexistente")
      assert_empty resultado
    end

    test "helper está disponible" do
      assert_respond_to self, :nombreobj
      assert_respond_to self, :ruta_responde_0p
    end

    test "constantes están definidas" do
      assert_kind_of Array, MESES
      assert_kind_of Array, NOSI
    end
  end
end