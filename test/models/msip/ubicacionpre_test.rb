# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class UbicacionpreTest < ActiveSupport::TestCase
    test "trigger crea" do
      ActiveRecord::Base.connection.execute(<<-SQL)
        INSERT INTO msip_ubicacionpre (nombre, pais_id, lugar,
          fechacreacion, created_at, updated_at)
          VALUES ('x', 212, 'y', '2024-04-25', '20240-04-25', '2024-04-25');
      SQL
      c = Msip::Ubicacionpre.where(fechacreacion: "2024-04-25")

      assert_equal "y / Dominica", c.take.nombre
      c.delete_all
    end

    test "trigger actualiza" do
      ActiveRecord::Base.connection.execute(<<-SQL)
        UPDATE msip_ubicacionpre#{" "}
          SET lugar='z'
          WHERE id=1;
      SQL
      u = Msip::Ubicacionpre.find(1)

      assert_equal "z / Colombia", u.nombre
    end

    test "crea simple" do
      assert_equal 1, Msip::Pais.where(id: 100).count
      pais = Msip::Pais.find(100)
      ubicacionpre = Ubicacionpre.create(PRUEBA_UBICACIONPRE2)

      assert_predicate ubicacionpre, :valid?
      assert_equal ubicacionpre.pais_id, pais.id
    end

    test "no valido pais 0" do
      assert_raises Exception do
        Ubicacionpre.create(PRUEBA_UBICACIONPRE2.merge(pais_id: 0))
      end
    end

    test "no valido sin nombre" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE2.merge(nombre: nil))

      assert_not_predicate u, :valid?
    end

    test "nombre estandar" do
      assert_nil Msip::Ubicacionpre.buscar_o_agregar(
        nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
      )

      u = Msip::Ubicacionpre.create(
        pais_id: 170,
        nombre: "x - por generar",
        lugar: "x",
        fechacreacion: "2023-12-07",
      )
      u.save

      assert u.valid?

      assert u.poner_nombre_estandar
      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, nil, nil, nil, nil, nil, nil, nil, nil
      )

      assert_operator idu, :>, 0
      u = Msip::Ubicacionpre.find(idu)

      assert_equal "Colombia", u.nombre
      assert_equal "", u.nombre_sin_pais

      u = Msip::Ubicacionpre.create(
        pais_id: 170,
        departamento_id: 11,
        nombre: "x - por completar",
        lugar: "x",
        fechacreacion: "2023-12-07",
      )
      u.save

      assert u.valid?

      assert u.poner_nombre_estandar

      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, nil, nil, nil, nil, nil, nil, nil
      )

      assert idu > 0
      u = Msip::Ubicacionpre.find(idu)

      assert_equal "Cundinamarca / Colombia", u.nombre
      assert_equal "Cundinamarca", u.nombre_sin_pais

      u = Msip::Ubicacionpre.create(
        pais_id: 170,
        departamento_id: 27,
        municipio_id: 1359,
        nombre: "x",
        lugar: "x",
      )
      u.save

      assert u.poner_nombre_estandar

      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, nil, nil, nil, nil, nil
      )

      assert_operator idu, :>, 0
      u = Msip::Ubicacionpre.find(idu)

      assert_equal "Une / Cundinamarca / Colombia", u.nombre
      assert_equal "Une / Cundinamarca", u.nombre_sin_pais

      u = Msip::Ubicacionpre.create(
        pais_id: 170,
        departamento_id: 27,
        municipio_id: 1359,
        centropoblado_id: 4872,
        nombre: "x",
        lugar: "x",
      )
      # no ponemos tsitio_id porque hasta centros poblados por convención
      # se han puesto en nil (tal vez porque podrían ser urbano o
      # urbano/rural).
      u.save

      assert u.poner_nombre_estandar

      idc = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, 4872, nil, nil, nil, nil, nil
      )

      assert_operator idc, :>, 0
      u = Msip::Ubicacionpre.find(idc)

      assert_equal "El Ramal / Une / Cundinamarca / Colombia", u.nombre
      assert_equal "El Ramal / Une / Cundinamarca", u.nombre_sin_pais

      # Vereda
      idv = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, "Vereda l", nil, nil, nil, nil
      )

      assert_operator idv, :>, 0
      u = Msip::Ubicacionpre.find(idv)

      assert_equal "Vereda l / Une / Cundinamarca / Colombia", u.nombre
      assert_equal "Vereda l / Une / Cundinamarca", u.nombre_sin_pais

      # Finca
      idf = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, "Vereda l", "Finca r", nil, nil, nil
      )

      assert_operator idf, :>, 0
      u = Msip::Ubicacionpre.find(idf)

      assert_equal "Finca r / Vereda l / Une / Cundinamarca / Colombia", u.nombre
      assert_equal "Finca r / Vereda l / Une / Cundinamarca", u.nombre_sin_pais

      # Si es una vereda con nombre de centro poblado suponemos que es centro
      # poblado
      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, "El Ramal", nil, nil, nil, nil
      )

      assert_equal idc, idu

      # tsitio no válido
      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, "Vereda l", nil, -1, nil, nil
      )

      assert_nil idu

      # tsitio rural
      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, "Vereda l", nil, 3, nil, nil
      )

      assert_equal idv, idu

      # tsitio rural
      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, "Vereda l", nil, 3, nil, nil
      )

      assert_equal idv, idu

      # tsitio rural
      idu = Msip::Ubicacionpre.buscar_o_agregar(
        170, 27, 1359, nil, nil, "Finca x", 3, nil, nil
      )

      assert_operator idu, :>, 0
    end

    test "no valido con nombre muy laaaaargo" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE2.merge(lugar: " " * 3000))

      assert_not_predicate u, :valid?
    end

    test "no valido con lugar largo" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE2.merge(lugar: " " * 1000))

      assert_not_predicate u, :valid?
    end

    test "no valido con sitio largo" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE.merge(sitio: " " * 1000))

      assert_not_predicate u, :valid?
    end

    test "nombre estandar 2" do
      u = Ubicacionpre.create(PRUEBA_UBICACIONPRE2)
      u.poner_nombre_estandar

      assert_equal("IMAGINA / Bulgaria", u.nombre)
      assert_equal("IMAGINA", u.nombre_sin_pais)
    end

    test "nomenclatura" do
      assert_equal ["", ""],
        Ubicacionpre.nomenclatura(nil, nil, nil, nil, nil, nil, nil)
      assert_equal ["a", ""],
        Ubicacionpre.nomenclatura("a", nil, nil, nil, nil, nil, nil)
      assert_equal ["b / a", "b"],
        Ubicacionpre.nomenclatura("a", "b", nil, nil, nil, nil, nil)
      assert_equal ["c / b / a", "c / b"],
        Ubicacionpre.nomenclatura("a", "b", "c", nil, nil, nil, nil)
      assert_equal ["b / a", "b"],
        Ubicacionpre.nomenclatura("a", "b", nil, "d", nil, nil, nil)
      assert_equal ["d / c / b / a", "d / c / b"],
        Ubicacionpre.nomenclatura("a", "b", "c", "d", nil, nil, nil)
      assert_equal ["Vereda v / m / d / p", "Vereda v / m / d"],
        Ubicacionpre.nomenclatura("p", "d", "m", nil, "v", nil, nil)
      assert_equal ["Vereda v / m / d / p", "Vereda v / m / d"],
        Ubicacionpre.nomenclatura("p", "d", "m", "c", "v", nil, nil)

      assert_equal ["e / d / c / b / a", "e / d / c / b"],
        Ubicacionpre.nomenclatura("a", "b", "c", "d", nil, "e", nil)
      assert_equal ["e / c / b / a", "e / c / b"],
        Ubicacionpre.nomenclatura("a", "b", "c", "", nil, "e", nil)
    end

    test "buscar o agregar" do
      u = Ubicacionpre.buscar_o_agregar(
        170, nil, nil, nil, nil, nil, nil, nil, nil, nil, false
      )

      assert_equal 1, u
    end

    test "existe" do
      ubicacionpre = Ubicacionpre.where(
        pais_id: 170, departamento_id: nil, municipio_id: nil, centropoblado_id: nil,
      )
      assert_equal 1, ubicacionpre.count
    end
  end
end
