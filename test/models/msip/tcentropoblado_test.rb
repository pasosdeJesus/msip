# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class TcentropobladoTest < ActiveSupport::TestCase
    test "valido" do
      tcentropoblado = Tcentropoblado.create(PRUEBA_TCENTROPOBLADO)

      assert_predicate tcentropoblado, :valid?
      tcentropoblado.destroy
    end

    test "no valido" do
      tcentropoblado = Tcentropoblado.new(PRUEBA_TCENTROPOBLADO)
      tcentropoblado.nombre = ""

      assert_not tcentropoblado.valid?
      tcentropoblado.destroy
    end

    test "existente" do
      tcentropoblado = Msip::Tcentropoblado.where(id: "C").take

      assert_equal("CORREGIMIENTO", tcentropoblado.nombre)
    end
  end
end
