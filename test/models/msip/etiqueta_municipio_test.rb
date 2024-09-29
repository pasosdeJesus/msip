# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class EtiquetaMunicipioTest < ActiveSupport::TestCase
    test "valido" do
      etiqueta = Etiqueta.create(PRUEBA_ETIQUETA)
      assert_predicate etiqueta, :valid?
      municipio = Municipio.create(PRUEBA_MUNICIPIO)
      assert_predicate municipio, :valid?

      etiqueta_municipio = EtiquetaMunicipio.create(
        etiqueta_id: etiqueta.id,
        municipio_id: municipio.id,
      )
      assert_predicate etiqueta_municipio, :valid?
      etiqueta_municipio.save

      etiqueta_municipio.destroy!
      municipio.destroy!
      etiqueta.destroy!
    end

    test "no valido" do
      etiqueta_municipio = EtiquetaMunicipio.create(
        etiqueta_id: nil,
        municipio_id: nil,
      )
      assert_not etiqueta_municipio.valid?
    end

  end
end
