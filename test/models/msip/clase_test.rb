require_relative "../../test_helper"

module Msip
  class ClaseTest < ActiveSupport::TestCase
    test "valido" do
      clase = Clase.create(PRUEBA_CLASE)

      assert_predicate clase, :valid?
      clase.destroy!
    end

    test "no valido" do
      clase = Clase.new(PRUEBA_CLASE)
      clase.nombre = ""

      assert_not clase.valid?
      clase.destroy
    end

    test "existente" do
      clase = Msip::Clase.where(id: 217).take

      assert_equal("Caracas", clase.nombre)
    end
  end
end
