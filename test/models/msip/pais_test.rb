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
      pais.destroy
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
      assert Msip::Pais.filtro_habilitado("si").count > 0
      assert_equal(0, Msip::Pais.filtro_habilitado("no").count)
      assert_equal(1, Msip::Pais.filtro_nombre("COLOMBIA").count)
      assert_equal(0, Msip::Pais.filtro_nombre("LOCOMBIA").count)
      assert_equal(0, Msip::Pais.filtro_observaciones("VIDIPOLA").count)
      assert Msip::Pais.filtro_fechacreacionini("2000-01-01").count > 0
      assert_equal(0, Msip::Pais.filtro_fechacreacionini("2030-01-01").count)
      assert_equal(0, Msip::Pais.filtro_fechacreacionfin("2000-01-01").count)
      assert Msip::Pais.filtro_fechacreacionfin("2030-01-01").count > 0
    end
  end
end
