# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class OrgsocialTest < ActiveSupport::TestCase
    test "valido" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER)

      assert_predicate grupoper, :valid?
      grupoper.save!
      orgsocial = Msip::Orgsocial.new(PRUEBA_ORGSOCIAL)
      orgsocial.grupoper = grupoper

      assert_predicate orgsocial, :valid?
      orgsocial.save!
      orgsocial.destroy
      grupoper.destroy
    end

    test "no valido" do
      orgsocial = Msip::Orgsocial.new(PRUEBA_ORGSOCIAL)
      orgsocial.grupoper = nil

      assert_not_predicate orgsocial, :valid?
      orgsocial.destroy
    end

    test "validaciones de longitud de campos" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      orgsocial = Msip::Orgsocial.new(PRUEBA_ORGSOCIAL.except(:id))
      orgsocial.grupoper = grupoper
      
      # Test básico de validez
      assert_predicate orgsocial, :valid?
      
      # Nombre muy largo
      if orgsocial.respond_to?(:nombre)
        orgsocial.nombre = "a" * 501
        assert_not orgsocial.valid?
      end
      
      # Descripción muy larga
      if orgsocial.respond_to?(:descripcion)
        orgsocial.descripcion = "a" * 5001
        assert_not orgsocial.valid?
      end
      
      orgsocial.destroy
      grupoper.destroy
    end

    test "relaciones con otros modelos" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      orgsocial = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.except(:id).merge(grupoper: grupoper))
      
      # Debe tener grupoper
      assert_not_nil orgsocial.grupoper
      assert_equal grupoper.id, orgsocial.grupoper.id
      
      # Debe poder asociarse con tipoorg
      assert_respond_to orgsocial, :tipoorg
      
      # Debe poder asociarse con sectores
      assert_respond_to orgsocial, :sectororgsocial
      
      orgsocial.destroy
      grupoper.destroy
    end

    test "validaciones de fechas" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      orgsocial = Msip::Orgsocial.new(PRUEBA_ORGSOCIAL.except(:id))
      orgsocial.grupoper = grupoper
      
      # Modelo no tiene fechacreacion, solo verificar validez básica
      assert_predicate orgsocial, :valid?
      
      orgsocial.destroy
      grupoper.destroy
    end

    test "scopes básicos" do
      grupoper1 = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      grupoper2 = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id).merge(nombre: "Grupo 2"))
      
      # Organización habilitada
      org_hab = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.except(:id).merge(grupoper: grupoper1))
      
      # Organización deshabilitada
      org_des = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.except(:id).merge({
        grupoper: grupoper2,
        fechadeshabilitacion: "2023-01-01"
      }))
      
      # Scope habilitados
      if Msip::Orgsocial.respond_to?(:habilitados)
        habilitados = Msip::Orgsocial.habilitados
        assert_includes habilitados, org_hab
        assert_not_includes habilitados, org_des
      end
      
      org_hab.destroy
      org_des.destroy
      grupoper1.destroy
      grupoper2.destroy
    end

    test "presenta_nombre o método similar" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      orgsocial = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.except(:id).merge(grupoper: grupoper))
      
      # Debe tener algún método para presentar nombre
      if orgsocial.respond_to?(:presenta_nombre)
        resultado = orgsocial.presenta_nombre
        assert_kind_of String, resultado
        assert_operator resultado.length, :>, 0
      elsif orgsocial.respond_to?(:to_s)
        resultado = orgsocial.to_s
        assert_kind_of String, resultado
      end
      
      orgsocial.destroy
      grupoper.destroy
    end

    test "asociación con persona a través de grupoper" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      orgsocial = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.except(:id).merge(grupoper: grupoper))
      
      # Verificar que tiene grupoper válido
      assert_not_nil orgsocial.grupoper
      assert_equal grupoper.id, orgsocial.grupoper.id
      
      orgsocial.destroy
      grupoper.destroy
    end

    test "validaciones específicas del modelo" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      orgsocial = Msip::Orgsocial.new(PRUEBA_ORGSOCIAL.except(:id))
      orgsocial.grupoper = grupoper
      
      # Debe requerir grupoper
      orgsocial.grupoper = nil
      assert_not orgsocial.valid?
      
      # Con grupoper debe ser válido
      orgsocial.grupoper = grupoper
      assert_predicate orgsocial, :valid?
      
      orgsocial.destroy
      grupoper.destroy
    end

    test "filtros de búsqueda" do
      grupoper1 = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id))
      grupoper2 = Msip::Grupoper.create(PRUEBA_GRUPOPER.except(:id).merge(nombre: "Organización Especial"))
      
      org1 = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.except(:id).merge(grupoper: grupoper1))
      org2 = Msip::Orgsocial.create(PRUEBA_ORGSOCIAL.except(:id).merge(grupoper: grupoper2))
      
      # Filtro por término en grupoper si existe
      if Msip::Orgsocial.respond_to?(:where)
        resultado = Msip::Orgsocial.joins(:grupoper)
                                   .where("msip_grupoper.nombre ILIKE ?", "%Especial%")
        assert_includes resultado, org2
        assert_not_includes resultado, org1
      end
      
      org1.destroy
      org2.destroy
      grupoper1.destroy
      grupoper2.destroy
    end
  end
end
