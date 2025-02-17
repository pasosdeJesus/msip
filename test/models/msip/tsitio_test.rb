# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class TsitioTest < ActiveSupport::TestCase
    test "valido" do
      tsitio = Tsitio.create(PRUEBA_TSITIO)

      assert_predicate tsitio, :valid?
      tsitio.destroy
    end

    test "no valido" do
      tsitio = Tsitio.new(PRUEBA_TSITIO)
      tsitio.nombre = ""

      assert_not tsitio.valid?
      tsitio.destroy
    end

    test "existente" do
      tsitio = Msip::Tsitio.find_by(id: 2)

      assert_equal("URBANO", tsitio.nombre)
    end
  end
end
