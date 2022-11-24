# frozen_string_literal: true

require "test_helper"

module Msip
  class VeredaTest < ActiveSupport::TestCase
    PRUEBA_VEREDA = {
      id: 1000000,
      nombre: "Vereda",
      municipio_id: 1,
      fechacreacion: "2022-02-14",
      created_at: "2022-02-14",
    }

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
      skip
      vereda = Vereda.where(id: 0).take

      assert_equal("SIN INFORMACIÓN", vereda.nombre)
    end
  end
end
