# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class FuenteprensaTest < ActiveSupport::TestCase
    test "valido" do
      fuenteprensa = Fuenteprensa.create(PRUEBA_FUENTEPRENSA)

      assert_predicate fuenteprensa, :valid?
      fuenteprensa.destroy
    end

    test "no valido" do
      fuenteprensa =
        Fuenteprensa.new(PRUEBA_FUENTEPRENSA)
      fuenteprensa.nombre = ""

      assert_not fuenteprensa.valid?
      fuenteprensa.destroy
    end

    test "existente" do
      fuenteprensa = Msip::Fuenteprensa.find_by(id: 1)

      assert_equal("EL TIEMPO", fuenteprensa.nombre)
    end
  end
end
