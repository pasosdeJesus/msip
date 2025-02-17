# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class EtiquetaPersonaTest < ActiveSupport::TestCase
    test "valido" do
      etiqueta = Etiqueta.create(PRUEBA_ETIQUETA)

      assert_predicate etiqueta, :valid?
      persona = Persona.create(PRUEBA_PERSONA)

      assert_predicate persona, :valid?
      usuario = ::Usuario.create(PRUEBA_USUARIO)

      assert_predicate usuario, :valid?

      etiqueta_persona = EtiquetaPersona.create(
        etiqueta_id: etiqueta.id,
        persona_id: persona.id,
        usuario_id: usuario.id,
        fecha: "2023-04-26",
        observaciones: "prueba",
      )

      assert_predicate etiqueta_persona, :valid?
      etiqueta_persona.save

      etiqueta_persona.destroy!
      persona.destroy!
      etiqueta.destroy!
    end

    test "no valido" do
      etiqueta_persona = EtiquetaPersona.create(
        etiqueta_id: nil,
        persona_id: nil,
        usuario_id: nil,
        fecha: "2023-04-26",
        observaciones: "prueba",
      )

      assert_not etiqueta_persona.valid?
    end
  end
end
