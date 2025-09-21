# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class CentropobladoTest < ActiveSupport::TestCase
    test "valido" do
      centropoblado = Centropoblado.create(PRUEBA_CENTROPOBLADO)

      assert_predicate centropoblado, :valid?
      centropoblado.destroy!

      # Para probar trigger de ubicacinpre reseteamos la conexion
      # e insertamos en SQL
      Pais.connection.reset!

      ## TRIGGER DE INSERCIÓN

      # connection.insert en lugar de connection.execute según
      # https://stackoverflow.com/questions/11024767/rails-activerecord-getting-the-id-of-a-raw-insert
      pais_id = Pais.connection.insert(
        "INSERT INTO msip_pais (nombre, fechacreacion) " \
          "VALUES ('a', '2024-07-19')",
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en pais
      assert_equal 1, Msip::Ubicacionpre.where(pais_id: pais_id).count
      assert_equal "", Msip::Ubicacionpre.find_by(pais_id: pais_id)
        .nombre_sin_pais
      departamento_id = Departamento.connection.insert(
        "INSERT INTO msip_departamento (nombre, pais_id, fechacreacion) " \
          "VALUES ('b', #{pais_id}, '2024-07-19')",
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # departamento
      assert_equal 1, Msip::Ubicacionpre
        .where(departamento_id: departamento_id).count
      assert_equal "b / a", Msip::Ubicacionpre
        .find_by(departamento_id: departamento_id).nombre
      assert_equal "b", Msip::Ubicacionpre
        .find_by(departamento_id: departamento_id).nombre_sin_pais

      municipio_id = Municipio.connection.insert(
        "INSERT INTO msip_municipio (nombre, departamento_id, fechacreacion) " \
          "VALUES ('c', #{departamento_id}, '2024-07-19')",
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # municipio
      assert_equal 1, Msip::Ubicacionpre.where(municipio_id: municipio_id).count
      assert_equal "c / b / a", Msip::Ubicacionpre.find_by(municipio_id: municipio_id).nombre
      assert_equal "c / b", Msip::Ubicacionpre.find_by(
        municipio_id: municipio_id,
      ).nombre_sin_pais

      centropoblado_id = Centropoblado.connection.insert(
        "INSERT INTO msip_centropoblado (nombre, municipio_id, fechacreacion) " \
          "VALUES ('c', #{municipio_id}, '2024-07-23')",
      )
      # Se disparó el trigger de creacion de ubicacionpre  por insercion en
      # municipio
      assert_equal 1, Msip::Ubicacionpre
        .where(centropoblado_id: centropoblado_id).count
      assert_equal "c / c / b / a", Msip::Ubicacionpre
        .find_by(centropoblado_id: centropoblado_id).nombre
      assert_equal "c / c / b", Msip::Ubicacionpre
        .find_by(centropoblado_id: centropoblado_id).nombre_sin_pais

      ## TRIGGER DE ACTUALIZACIÓN

      cup = "UPDATE msip_centropoblado SET nombre='x'  " \
        "WHERE id='#{centropoblado_id.to_i}'"
      Pais.connection.execute(cup)

      assert_equal "x / c / b / a", Msip::Ubicacionpre
        .find_by(centropoblado_id: centropoblado_id).nombre
      assert_equal "x / c / b", Msip::Ubicacionpre
        .find_by(centropoblado_id: centropoblado_id).nombre_sin_pais

      ## TRIGGER DE ELIMINACIÓN
      ## No hay caso mínimo y complejo, toca eliminar asociados uno a uno antes
      Centropoblado.connection.execute(
        "DELETE FROM msip_centropoblado WHERE id='#{centropoblado_id.to_i}'",
      )
      # Se debió disparar el trigger de eliminación de ubicacionpre
      assert_equal 0, Msip::Ubicacionpre
        .where(centropoblado_id: centropoblado_id).count

      Municipio.connection.insert(
        "DELETE FROM msip_municipio WHERE id='#{municipio_id.to_i}'",
      )
      # Se debió disparar el trigger de eliminación de ubicacionpre
      assert_equal 0, Msip::Ubicacionpre.where(municipio_id: municipio_id).count

      Departamento.connection.insert(
        "DELETE FROM msip_departamento WHERE id='#{departamento_id.to_i}'",
      )
      # Se debió disparar el trigger de eliminación de ubicacionpre
      assert_equal 0, Msip::Ubicacionpre.where(departamento_id: departamento_id).count
      Pais.connection.insert(
        "DELETE FROM msip_pais WHERE id='#{pais_id.to_i}'",
      )

      assert_equal 0, Msip::Ubicacionpre.where(pais_id: pais_id).count
    end

    test "no valido" do
      centropoblado = Centropoblado.new(PRUEBA_CENTROPOBLADO)
      centropoblado.nombre = ""

      assert_not centropoblado.valid?
      centropoblado.destroy
    end

    test "existente" do
      centropoblado = Msip::Centropoblado.find_by(id: 1)

      assert_equal("Une", centropoblado.nombre)
    end
  end
end
