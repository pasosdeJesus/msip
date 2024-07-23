# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class DepartamentoTest < ActiveSupport::TestCase
    test "valido" do
      departamento = Departamento.create(PRUEBA_DEPARTAMENTO)

      assert_predicate departamento, :valid?
      departamento.destroy

      # Para probar trigger de ubicacinpre reseteamos la conexion 
      # e insertamos en SQL
      Pais.connection.reset!

      ## TRIGGER DE INSERCIÓN

      # connection.insert en lugar de connection.execute según
      # https://stackoverflow.com/questions/11024767/rails-activerecord-getting-the-id-of-a-raw-insert
      pais_id = Pais.connection.insert(
        "INSERT INTO msip_pais (nombre, fechacreacion)"\
        " VALUES ('x', '2024-07-19')"
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en pais
      assert_equal 1, Msip::Ubicacionpre.where(pais_id: pais_id).count
      assert_equal "", Msip::Ubicacionpre.where(pais_id: pais_id).take.nombre_sin_pais
      departamento_id = Departamento.connection.insert(
        "INSERT INTO msip_departamento (nombre, pais_id, fechacreacion)"\
        " VALUES ('y', #{pais_id}, '2024-07-19')"
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # departamento
      assert_equal 1, Msip::Ubicacionpre.where(departamento_id: departamento_id).count
      assert_equal "y", Msip::Ubicacionpre.where(departamento_id: departamento_id).take.nombre_sin_pais


      municipio_id = Municipio.connection.insert(
        "INSERT INTO msip_municipio (nombre, departamento_id, fechacreacion)"\
        " VALUES ('y', #{departamento_id}, '2024-07-19')"
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # municipio
      assert_equal 1, Msip::Ubicacionpre.where(municipio_id: municipio_id).count
      assert_equal "y / y / x", Msip::Ubicacionpre.
        where(municipio_id: municipio_id).take.nombre
      assert_equal "y / y", Msip::Ubicacionpre.
        where(municipio_id: municipio_id).take.nombre_sin_pais


      ## TRIGGER DE ACTUALIZACIÓN

      cup = "UPDATE msip_departamento SET nombre='z' "\
        "WHERE id='#{departamento_id.to_i}'"
      Pais.connection.execute(cup)
      assert_equal "z / x", Msip::Ubicacionpre.
        where(departamento_id: departamento_id, municipio_id: nil).take.
        nombre
      assert_equal "z", Msip::Ubicacionpre.
        where(departamento_id: departamento_id, municipio_id: nil).take.
        nombre_sin_pais
      assert_equal "y / z / x", Msip::Ubicacionpre.
        where(municipio_id: municipio_id).take.nombre
      assert_equal "y / z", Msip::Ubicacionpre.
        where(municipio_id: municipio_id).take.nombre_sin_pais


      ## TRIGGER DE ELIMINACIÓN
      ## No hay caso mínimo y complejo, toca eliminar asociados uno a uno antes

      Pais.connection.insert(
        "DELETE FROM msip_municipio WHERE id='#{municipio_id.to_i}'"
      )
      Pais.connection.insert(
        "DELETE FROM msip_departamento WHERE id='#{departamento_id.to_i}'"
      )
      Pais.connection.insert(
        "DELETE FROM msip_pais WHERE id='#{pais_id.to_i}'"
      )
      assert_equal 0, Msip::Ubicacionpre.where(pais_id: pais_id).count
    end

    test "no valido" do
      departamento = Departamento.new(PRUEBA_DEPARTAMENTO)
      departamento.nombre = ""

      assert_not departamento.valid?
      departamento.destroy
    end

    test "existente" do
      departamento = Msip::Departamento.where(pais_id: 862, id: 1).take

      assert_equal("Distrito Capital", departamento.nombre)
    end
  end
end
