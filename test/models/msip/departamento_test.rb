# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class DepartamentoTest < ActiveSupport::TestCase
    test "valido" do
      departamento = Departamento.create(PRUEBA_DEPARTAMENTO)

      assert_predicate departamento, :valid?
      departamento.destroy
    end

    test "no valido" do
      departamento = Departamento.new(PRUEBA_DEPARTAMENTO)
      departamento.nombre = ""

      assert_not departamento.valid?
      departamento.destroy
    end

    test "existente" do
      departamento = Msip::Departamento.find_by(pais_id: 862, id: 1)

      assert_equal("Distrito Capital", departamento.nombre)
    end
  end
end
