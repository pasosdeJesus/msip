# frozen_string_literal: true

require "test_helper"

module Msip
  class TipoorgTest < ActiveSupport::TestCase
    test "valido" do
      tipoorg = Msip::Tipoorg.create(
        PRUEBA_TIPOORG,
      )

      assert_predicate(tipoorg, :valid?)
      tipoorg.destroy
    end

    test "no valido" do
      tipoorg = Msip::Tipoorg.new(
        PRUEBA_TIPOORG,
      )
      tipoorg.nombre = ""

      assert_not(tipoorg.valid?)
      tipoorg.destroy
    end

    test "existente" do
      tipoorg = Msip::Tipoorg.where(id: 1).take

      assert tipoorg.valid?

      assert_equal("ORGANIZACIÓN DE LA SOCIEDAD CIVIL (ACOMPAÑADA)", tipoorg.nombre)
    end
  end
end
