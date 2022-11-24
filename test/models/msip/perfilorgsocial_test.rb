# frozen_string_literal: true

require "test_helper"

module Msip
  class PerfilorgsocialTest < ActiveSupport::TestCase
    test "nuevo valido" do
      perfilorgsocial = Perfilorgsocial.create(PRUEBA_PERFILORGSOCIAL)

      assert_predicate perfilorgsocial, :valid?
      perfilorgsocial.destroy
    end

    test "nuevo no valido" do
      perfilorgsocial = Perfilorgsocial.new(PRUEBA_PERFILORGSOCIAL)
      perfilorgsocial.nombre = ""

      assert_not perfilorgsocial.valid?
      perfilorgsocial.destroy
    end
  end
end
