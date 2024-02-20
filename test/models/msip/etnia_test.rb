# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class EtniaTest < ActiveSupport::TestCase
    test "valido" do
      etnia = Etnia.create(PRUEBA_ETNIA)

      assert_predicate etnia, :valid?
      etnia.destroy
    end

    test "no valido" do
      etnia = Etnia.new(PRUEBA_ETNIA)
      etnia.nombre = ""

      assert_not etnia.valid?
      etnia.destroy
    end

    test "existente" do
      etnia = Msip::Etnia.find(1)

      assert_equal("SIN INFORMACIÓN", etnia.nombre)
    end
  end
end
