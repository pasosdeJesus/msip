# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class MunicipioTest < ActiveSupport::TestCase
    test "valido" do
      municipio = Municipio.create(PRUEBA_MUNICIPIO)

      assert_predicate municipio, :valid?
      municipio.destroy
    end

    test "no valido" do
      municipio = Municipio.new(PRUEBA_MUNICIPIO)
      municipio.nombre = ""

      assert_not municipio.valid?
      municipio.destroy
    end

    test "existente" do
      municipio = Msip::Municipio.find_by(id: 1359)

      assert_equal("Une", municipio.nombre)
    end
  end
end
