# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  # Como nuestras pruebas a modelos se hacen en una base de datos
  # que tiene muchos datos básicos (e.g información geográfica),
  # no usamo database_clenaer, sino que las pruebas que crean elementos
  # de datos básicos
  # son responsables de borrarlos
  class PaisTest < ActiveSupport::TestCase
    test "nuevo valido" do
      pais = Pais.create(PRUEBA_PAIS)

      assert_predicate pais, :valid?

      # Parece que minitest corre en un modo extraño de la base
      # de datos (no parecer ser una transacción), porque:
      # 1. Los cambios no se logran ver simultaneamente en una segunda
      #    conexión
      # 2. Los triggers no se disparan.
      # Experimentando con funciones de PostgreSQLAdapter
      # descubrimos que al hacer reset e insert a bajo nivel
      # 1. Los cambios si ocurren en la base de datos y se ven desde otra
      #    conexión.
      # 2. Los triggers si se ejecutan

      pais.destroy

      # Para probar trigger de ubicacinpre reseteamos la conexion
      # e insertamos en SQL
      Pais.connection.reset!

      ## TRIGGER DE INSERCIÓN

      # connection.insert en lugar de connection.execute según
      # https://stackoverflow.com/questions/11024767/rails-activerecord-getting-the-id-of-a-raw-insert
      pais_id = Pais.connection.insert(
        "INSERT INTO msip_pais (nombre, fechacreacion) " \
          "VALUES ('x', '2024-07-19')",
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en pais
      assert_equal 1, Msip::Ubicacionpre.where(pais_id: pais_id).count
      assert_equal "", Msip::Ubicacionpre.find_by(pais_id: pais_id).nombre_sin_pais

      ## TRIGGER DE ACTUALIZACIÓN CASO MÍNIMO

      cup = "UPDATE msip_pais SET nombre='y' WHERE id='#{pais_id.to_i}'"
      Pais.connection.execute(cup)

      # Se debió disparar el trigger de actualización de ubicacionpre
      assert_equal "y", Msip::Ubicacionpre.find_by(pais_id: pais_id).nombre
      assert_equal "", Msip::Ubicacionpre.find_by(pais_id: pais_id).nombre_sin_pais

      ## TRIGGER DE ACTUALIZACIÓN CASO AMPLIO

      departamento_id = Departamento.connection.insert(
        "INSERT INTO msip_departamento (nombre, pais_id, fechacreacion) " \
          "VALUES ('y', #{pais_id}, '2024-07-19')",
      )

      assert_equal 1, Msip::Ubicacionpre
        .where(departamento_id: departamento_id).count
      assert_equal "y / y", Msip::Ubicacionpre
        .find_by(departamento_id: departamento_id).nombre
      assert_equal "y", Msip::Ubicacionpre
        .find_by(departamento_id: departamento_id).nombre_sin_pais

      municipio_id = Municipio.connection.insert(
        "INSERT INTO msip_municipio (nombre, departamento_id, fechacreacion) " \
          "VALUES ('y', #{departamento_id}, '2024-07-19')",
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # municipio
      assert_equal 1, Msip::Ubicacionpre.where(municipio_id: municipio_id).count
      assert_equal "y / y / y", Msip::Ubicacionpre
        .find_by(municipio_id: municipio_id).nombre
      assert_equal "y / y", Msip::Ubicacionpre
        .find_by(municipio_id: municipio_id).nombre_sin_pais

      cup = "UPDATE msip_pais SET nombre='z' WHERE id='#{pais_id.to_i}'"
      Pais.connection.execute(cup)

      # Se debió disparar el trigger de actualización de ubicacionpre
      assert_equal "z", Msip::Ubicacionpre.find_by(pais_id: pais_id).nombre
      assert_equal "", Msip::Ubicacionpre
        .find_by(pais_id: pais_id).nombre_sin_pais
      assert_equal "y / z", Msip::Ubicacionpre
        .find_by(departamento_id: departamento_id, municipio_id: nil).nombre
      assert_equal "y", Msip::Ubicacionpre
        .find_by(departamento_id: departamento_id, municipio_id: nil)
        .nombre_sin_pais
      assert_equal "y / y / z", Msip::Ubicacionpre
        .find_by(municipio_id: municipio_id).nombre
      assert_equal "y / y", Msip::Ubicacionpre
        .find_by(municipio_id: municipio_id).nombre_sin_pais

      Pais.connection.insert(
        "DELETE FROM msip_municipio WHERE id='#{municipio_id.to_i}'",
      )
      Pais.connection.insert(
        "DELETE FROM msip_departamento WHERE id='#{departamento_id.to_i}'",
      )

      ## TRIGGER DE ELIMINACIÓN
      ## No hay caso mínimo y complejo, toca eliminar asociados uno a uno antes

      Pais.connection.insert(
        "DELETE FROM msip_pais WHERE id='#{pais_id.to_i}'",
      )
      # Se debió disparar el trigger de eliminación de ubicacionpre
      assert_equal 0, Msip::Ubicacionpre.where(pais_id: pais_id).count
    end

    test "nuevo no valido" do
      pais = Pais.new(PRUEBA_PAIS)
      pais.nombre = ""

      assert_not pais.valid?
      pais.nombre = "x"

      assert_predicate pais, :valid?
      pais.fechacreacion = "1999-01-01"

      assert_not pais.valid?
      pais.fechacreacion = "2004-01-01"

      assert_predicate pais, :valid?
      pais.fechadeshabilitacion = "2000-01-01"

      assert_not pais.valid?
      pais.fechadeshabilitacion = "2005-01-01"

      assert_predicate pais, :valid?

      pais.destroy
    end

    test "existente" do
      pais = Msip::Pais.find(862) # Venezuela

      assert_equal("Venezuela", pais.nombre)
    end

    test "otras de basica" do
      pais = Msip::Pais.find(862) # Venezuela

      assert_equal 862, pais.busca_valor
      assert_operator Msip::Pais.filtro_habilitado("si").count, :>, 0
      assert_equal(0, Msip::Pais.filtro_habilitado("no").count)
      assert_equal(1, Msip::Pais.filtro_nombre("COLOMBIA").count)
      assert_equal(0, Msip::Pais.filtro_nombre("LOCOMBIA").count)
      assert_equal(0, Msip::Pais.filtro_observaciones("VIDIPOLA").count)
      assert_operator Msip::Pais.filtro_fechacreacionini("2000-01-01").count, :>, 0
      assert_equal(0, Msip::Pais.filtro_fechacreacionini("2030-01-01").count)
      assert_equal(0, Msip::Pais.filtro_fechacreacionfin("2000-01-01").count)
      assert_operator Msip::Pais.filtro_fechacreacionfin("2030-01-01").count, :>, 0
    end
  end
end
