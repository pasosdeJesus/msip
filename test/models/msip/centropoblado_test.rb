# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class CentropobladoTest < ActiveSupport::TestCase
    test "valido" do
      centropoblado = Centropoblado.create(PRUEBA_CENTROPOBLADO)

      assert_predicate centropoblado, :valid?
      centropoblado.destroy!
    end

    test "no valido" do
      centropoblado = Centropoblado.new(PRUEBA_CENTROPOBLADO)
      centropoblado.nombre = ""

      assert_not centropoblado.valid?
      centropoblado.destroy
    end

    test "existente" do
      centropoblado = Msip::Centropoblado.find_by(id: 1)

      assert_equal("Une", centropoblado.nombre)
    end
  end
end
