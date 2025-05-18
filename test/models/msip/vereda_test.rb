# frozen_string_literal: true

require "test_helper"

module Msip
  class VeredaTest < ActiveSupport::TestCase
    test "valido" do
      vereda = Vereda.create(
        PRUEBA_VEREDA,
      )

      assert_predicate(vereda, :valid?)
      vereda.destroy
    end

    test "no valido" do
      vereda = Vereda.new(
        PRUEBA_VEREDA,
      )
      vereda.nombre = ""

      assert_not(vereda.valid?)
      vereda.destroy
    end

    test "existente" do
      vereda = Vereda.find_by(id: 1)

      assert_equal("Nuevo Morichal", vereda.nombre)
    end
  end
end
