# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class UbicacionpreTest < ActiveSupport::TestCase
    test "crea simple" do
      assert_equal 1, Msip::Pais.where(id: 100).count
      pais = Msip::Pais.find(100)
      ubicacionpre = Ubicacionpre.create(PRUEBA_UBICACIONPRE)

      assert_predicate ubicacionpre, :valid?
      assert_equal ubicacionpre.pais_id, pais.id
    end

    test "no valido pais 0" do
      assert_raises Exception do
        Ubicacionpre.create(PRUEBA_UBICACIONPRE.merge(pais_id: 0))
      end
    end

    test "no valido sin nombre" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE.merge(nombre: nil))
      assert_not_predicate u, :valid?
    end

    test "no valido con nombre muuy largo" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE.merge(lugar: ' '*3000))
      assert_not_predicate u, :valid?
    end

    test "no valido con lugar largo" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE.merge(lugar: ' '*1000))
      assert_not_predicate u, :valid?
    end

    test "no valido con sitio largo" do
      u= Ubicacionpre.create(PRUEBA_UBICACIONPRE.merge(sitio: ' '*1000))
      assert_not_predicate u, :valid?
    end

    test "nombre estandar" do
      u= Ubicacionpre.create(PRUEBA_UBICACIONPRE)
      u.poner_nombre_estandar
      assert_equal u.nombre, "Cesar / Bulgaria"
      assert_equal u.nombre_sin_pais, "Cesar"
    end

    test "nomenclatura" do
      assert_equal [nil, nil],
        Ubicacionpre::nomenclatura(nil, nil, nil, nil, nil, nil)
      assert_equal ["a", nil],
        Ubicacionpre::nomenclatura("a", nil, nil, nil, nil, nil)
      assert_equal ["b / a", "b"],
        Ubicacionpre::nomenclatura("a", "b", nil, nil, nil, nil)
      assert_equal ["c / b / a", "c / b"],
        Ubicacionpre::nomenclatura("a", "b", "c", nil, nil, nil)
      assert_equal ["b / a", "b"],
        Ubicacionpre::nomenclatura("a", "b", nil, "d", nil, nil)
      assert_equal ["d / c / b / a", "d / c / b"],
        Ubicacionpre::nomenclatura("a", "b", "c", "d", nil, nil)
      assert_equal ["e / d / c / b / a", "e / d / c / b"],
        Ubicacionpre::nomenclatura("a", "b", "c", "d", "e", nil)
      assert_equal ["e / c / b / a", "e / c / b"],
        Ubicacionpre::nomenclatura("a", "b", "c", "", "e", nil)
    end

    test "buscar o agregar" do
      u = Ubicacionpre::buscar_o_agregar(
        170, nil, nil, nil, nil, nil, nil, nil, nil, false)
      assert_nil u
    end





    # test "existe" do
    #  ubicacionpre = Ubicacionpre.where(
    #    pais_id: 170, departamento_id: nil, municipio_id: nil, clase_id: nil)
    #  assert_equal 1, ubicacionpre.count
    # end
  end
end
