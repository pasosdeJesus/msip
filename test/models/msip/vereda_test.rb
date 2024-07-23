# frozen_string_literal: true

require "test_helper"

module Msip
  class VeredaTest < ActiveSupport::TestCase
    test "valido" do
      vereda = Vereda.create(
        PRUEBA_VEREDA,
      )

      assert_predicate(vereda, :valid?)
      vereda.destroy

      # Para probar trigger de ubicacinpre reseteamos la conexion 
      # e insertamos en SQL
      Pais.connection.reset!

      ## TRIGGER DE INSERCIÓN

      # connection.insert en lugar de connection.execute según
      # https://stackoverflow.com/questions/11024767/rails-activerecord-getting-the-id-of-a-raw-insert
      pais_id = Pais.connection.insert(
        "INSERT INTO msip_pais (nombre, fechacreacion)"\
        " VALUES ('a', '2024-07-19')"
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en pais
      assert_equal 1, Msip::Ubicacionpre.where(pais_id: pais_id).count
      assert_equal "", Msip::Ubicacionpre.where(pais_id: pais_id).take.
        nombre_sin_pais
      departamento_id = Departamento.connection.insert(
        "INSERT INTO msip_departamento (nombre, pais_id, fechacreacion)"\
        " VALUES ('b', #{pais_id}, '2024-07-19')"
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # departamento
      assert_equal 1, Msip::Ubicacionpre.
        where(departamento_id: departamento_id).count
      assert_equal "b / a", Msip::Ubicacionpre.
        where(departamento_id: departamento_id).take.nombre
      assert_equal "b", Msip::Ubicacionpre.
        where(departamento_id: departamento_id).take.nombre_sin_pais

      municipio_id = Municipio.connection.insert(
        "INSERT INTO msip_municipio (nombre, departamento_id, fechacreacion)"\
        " VALUES ('c', #{departamento_id}, '2024-07-19')"
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # municipio
      assert_equal 1, Msip::Ubicacionpre.where(municipio_id: municipio_id).count
      assert_equal "c / b / a", Msip::Ubicacionpre.
        where(municipio_id: municipio_id).take.nombre
      assert_equal "c / b", Msip::Ubicacionpre.
        where(municipio_id: municipio_id).take.nombre_sin_pais

      vereda_id = Centropoblado.connection.insert(
        "INSERT INTO msip_vereda "\
        "(nombre, municipio_id, fechacreacion, created_at, updated_at)"\
        " VALUES ('v', #{municipio_id}, '2024-07-23', NOW(), NOW())"
      )
      # Se disparó el trigger de creacion de ubicacionpre  por inserción en
      # vereda
      assert_equal 1, Msip::Ubicacionpre.
        where(vereda_id: vereda_id).count
      assert_equal "Vereda v / c / b / a", Msip::Ubicacionpre.
        where(vereda_id: vereda_id).take.nombre
      assert_equal "Vereda v / c / b", Msip::Ubicacionpre.
        where(vereda_id: vereda_id).take.nombre_sin_pais

      ## TRIGGER DE ACTUALIZACIÓN

      cup = "UPDATE msip_vereda SET nombre='x' "\
        " WHERE id='#{vereda_id.to_i}'"
      Pais.connection.execute(cup)
      assert_equal "Vereda x / c / b / a", Msip::Ubicacionpre.
        where(vereda_id: vereda_id).take.nombre
      assert_equal "Vereda x / c / b", Msip::Ubicacionpre.
        where(vereda_id: vereda_id).take.nombre_sin_pais


      ## TRIGGER DE ELIMINACIÓN
      ## No hay caso mínimo y complejo, toca eliminar asociados uno a uno antes
      Centropoblado.connection.execute(
        "DELETE FROM msip_vereda WHERE id='#{vereda_id.to_i}'"
      )
      # Se debió disparar el trigger de eliminación de ubicacionpre 
      assert_equal 0, Msip::Ubicacionpre.
        where(vereda_id: vereda_id).count


      Municipio.connection.insert(
        "DELETE FROM msip_municipio WHERE id='#{municipio_id.to_i}'"
      )
      # Se debió disparar el trigger de eliminación de ubicacionpre 
      assert_equal 0, Msip::Ubicacionpre.where(municipio_id: municipio_id).count

      Departamento.connection.insert(
        "DELETE FROM msip_departamento WHERE id='#{departamento_id.to_i}'"
      )
      # Se debió disparar el trigger de eliminación de ubicacionpre 
      assert_equal 0, Msip::Ubicacionpre.where(departamento_id: departamento_id).count
      Pais.connection.insert(
        "DELETE FROM msip_pais WHERE id='#{pais_id.to_i}'"
      )
      assert_equal 0, Msip::Ubicacionpre.where(pais_id: pais_id).count
    end

    test "no valido" do
      vereda = Vereda.new(
        PRUEBA_VEREDA,
      )
      vereda.nombre = ""

      assert_not(vereda.valid?)
      vereda.destroy
    end

    test "existente" do
      vereda = Vereda.where(id: 1).take

      assert_equal("Nuevo Morichal", vereda.nombre)
    end
  end
end
