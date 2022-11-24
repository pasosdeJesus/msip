# frozen_string_literal: true

require "test_helper"

module Msip
  class TrivalenteTest < ActiveSupport::TestCase
    test "valido" do
      trivalente = Trivalente.create(
        PRUEBA_TRIVALENTE,
      )

      assert_predicate(trivalente, :valid?)
      trivalente.destroy
    end

    test "no valido" do
      trivalente = Trivalente.new(
        PRUEBA_TRIVALENTE,
      )
      trivalente.nombre = ""

      assert_not(trivalente.valid?)
      trivalente.destroy
    end

    test "existente" do
      trivalente = Trivalente.where(id: 1).take

      assert_equal("SIN RESPUESTA", trivalente.nombre)
    end
  end
end
