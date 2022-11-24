# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class OficinaTest < ActiveSupport::TestCase
    test "valido" do
      oficina = Oficina.create(PRUEBA_OFICINA)

      assert_predicate oficina, :valid?
      oficina.destroy
    end

    test "no valido" do
      oficina = Oficina.new(PRUEBA_OFICINA)
      oficina.nombre = ""

      assert_not oficina.valid?
      oficina.destroy
    end

    test "No valido por cantidad de caracteres en observaciones" do
      oficina = Oficina.new(PRUEBA_OFICINA)
      oficina.observaciones = "X" * 5001

      assert_not oficina.valid?
      oficina.destroy
    end

    test "existente" do
      oficina = Msip::Oficina.find(1)

      assert_equal("SIN INFORMACIÓN", oficina.nombre)
    end
  end
end
