require_relative "../../test_helper"

module Msip
  class EstadosolTest < ActiveSupport::TestCase
    test "valido" do
      estadosol = Msip::Estadosol.create(PRUEBA_ESTADOSOL)

      assert_predicate estadosol, :valid?
      estadosol.destroy
    end

    test "no valido por falta de nombre" do
      estadosol = Msip::Estadosol.new(PRUEBA_ESTADOSOL)
      estadosol.nombre = ""

      assert_not estadosol.valid?
      estadosol.destroy
    end

    test "valido sin observaciones" do
      estadosol = Msip::Estadosol.create(PRUEBA_ESTADOSOL)
      estadosol.observaciones = nil

      assert_predicate estadosol, :valid?
      estadosol.destroy
    end

    test "existente" do
      estadosol = Msip::Estadosol.find(1)

      assert_predicate estadosol, :valid?
      assert_equal("PENDIENTE", estadosol.nombre)
      estadosol.destroy
    end
  end
end
