# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class BitacoraTest < ActiveSupport::TestCase
    test "valido" do
      bitacora = Msip::Bitacora.create(PRUEBA_BITACORA)

      assert_predicate bitacora, :valid?
      bitacora.destroy
    end

    test "no valido por falta de fecha" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.fecha = nil

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "no valido por falta de fecha 2" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.fecha = ""

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "no valido por ip larga" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.ip = "x" * 600

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "no valido por modelo largo" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.modelo = "x" * 6000

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "valido sin detalle" do
      bitacora = Msip::Bitacora.create(PRUEBA_BITACORA)
      bitacora.detalle = nil

      assert_predicate bitacora, :valid?
      bitacora.destroy
    end
  end
end
