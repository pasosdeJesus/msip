# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class UbicacionTest < ActiveSupport::TestCase
    test "simple" do
      pais = Pais.find(862)
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      ubicacion.pais = pais

      assert_predicate ubicacion, :valid?
    end

    test "no valido" do
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      ubicacion.id_tsitio = nil

      assert_not ubicacion.valid?
    end

    test "no valido 2" do
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      ubicacion.id_pais = nil

      assert_not ubicacion.valid?
    end

    test "presenta_nombre" do
      u = Ubicacion.create(PRUEBA_UBICACION)

      assert_equal "Venezuela / Distrito Capital / Bolivariano Libertador / Caracas",
        u.presenta_nombre
      assert_equal "Venezuela / Distrito Capital / Bolivariano Libertador",
        u.presenta_nombre({ sin_clase: 1 })
      assert_equal "Venezuela / Distrito Capital",
        u.presenta_nombre({ sin_clase: 1, sin_municipio: 1 })
      assert_equal "Venezuela",
        u.presenta_nombre({ sin_clase: 1, sin_municipio: 1, sin_departamento: 1 })
      assert_equal "",
        u.presenta_nombre({
          sin_clase: 1,
          sin_municipio: 1,
          sin_departamento: 1,
          sin_pais: 1,
        })
    end
  end
end
