# frozen_string_literal: true

require "test_helper"

module Msip
  class TemaTest < ActiveSupport::TestCase
    test "nuevo valido" do
      perfilorgsocial = Tema.create(PRUEBA_TEMA)

      assert_predicate perfilorgsocial, :valid?
      perfilorgsocial.destroy
    end

    test "nuevo no valido" do
      perfilorgsocial = Tema.new(PRUEBA_TEMA)
      perfilorgsocial.nombre = ""

      assert_not perfilorgsocial.valid?
      perfilorgsocial.destroy
    end
  end
end
