# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class TrelacionTest < ActiveSupport::TestCase
    test "valido" do
      trelacion = Trelacion.create(PRUEBA_TRELACION)

      assert_predicate trelacion, :valid?
      trelacion.destroy!
    end

    test "no valido" do
      trelacion = Trelacion.new(PRUEBA_TRELACION)
      trelacion.nombre = ""

      assert_not trelacion.valid?
      trelacion.destroy!
    end

    test "existente" do
      trelacion = Msip::Trelacion.find_by(id: "SI")

      assert_equal("SIN INFORMACIÓN", trelacion.nombre)
    end
  end
end
