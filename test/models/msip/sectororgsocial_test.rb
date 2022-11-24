require_relative "../../test_helper"

module Msip
  class SectororgsocialTest < ActiveSupport::TestCase
    test "valido" do
      sectororgsocial = Msip::Sectororgsocial.create(PRUEBA_SECTORORGSOCIAL)

      assert_predicate sectororgsocial, :valid?
      sectororgsocial.save!
      sectororgsocial.destroy
    end

    test "no valido por falta de nombre" do
      sectororgsocial = Msip::Sectororgsocial.new(PRUEBA_SECTORORGSOCIAL)
      sectororgsocial.nombre = ""

      assert_not sectororgsocial.valid?
      sectororgsocial.destroy
    end

    test "no valido por nombre largo" do
      sectororgsocial = Msip::Sectororgsocial.new(PRUEBA_SECTORORGSOCIAL)
      sectororgsocial.nombre = "x" * 600

      assert_not sectororgsocial.valid?
      sectororgsocial.destroy
    end

    test "no valido por observacion larga" do
      sectororgsocial = Msip::Sectororgsocial.new(PRUEBA_SECTORORGSOCIAL)
      sectororgsocial.observaciones = "x" * 6000

      assert_not sectororgsocial.valid?
      sectororgsocial.destroy
    end

    test "valido sin observacion" do
      sectororgsocial = Msip::Sectororgsocial.create(PRUEBA_SECTORORGSOCIAL)
      sectororgsocial.observaciones = nil

      assert_predicate sectororgsocial, :valid?
      sectororgsocial.destroy
    end
  end
end
