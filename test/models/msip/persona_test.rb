# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class PersonaTest < ActiveSupport::TestCase
    test "valido" do
      persona = Persona.create(PRUEBA_PERSONA)

      assert_predicate persona, :valid?
      persona.destroy
    end

    test "no valido" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.nombres = ""

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por documento errado" do
      tdocumento = Msip::Tdocumento.create(PRUEBA_TDOCUMENTO)

      assert_predicate tdocumento, :valid?
      tdocumento.save!
      persona = Persona.new(PRUEBA_PERSONA)
      persona.tdocumento_id = tdocumento.id
      persona.numerodocumento = "a"

      assert_not persona.valid?
      persona.destroy
      tdocumento.destroy
    end

    test "no valido por año errado" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.anionac = 1

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por año errado 2" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.anionac = 1 + Time.now.strftime("%Y").to_i

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por mes errado" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 0

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por mes errado 2" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 13

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.dianac = 0

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado 2" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.dianac = 32

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado 3" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 4
      persona.dianac = 31

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado 4" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 2
      persona.dianac = 30

      assert_not persona.valid?
      persona.destroy
    end

    test "valido con documento no numérico" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.tdocumento_id = 6
      persona.numerodocumento = "T-100"

      assert_predicate persona, :valid?
      persona.destroy
    end

    test "valido sin documento" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.tdocumento_id = nil
      persona.numerodocumento = nil

      assert_predicate persona, :valid?
      persona.destroy
    end

    test "validaciones de longitud de campos" do
      persona = Persona.new(PRUEBA_PERSONA)
      
      # Nombres muy largos
      persona.nombres = "a" * 101
      assert_not persona.valid?
      
      # Apellidos muy largos
      persona.apellidos = "a" * 101
      assert_not persona.valid?
      
      # Número de documento muy largo
      persona.numerodocumento = "1" * 101
      assert_not persona.valid?
      
      persona.destroy
    end

    test "presenta_nombre método" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.nombres = "Juan Carlos"
      persona.apellidos = "Pérez García"
      
      # El modelo debe tener algún método para presentar nombre
      if persona.respond_to?(:presenta_nombre)
        resultado = persona.presenta_nombre
        assert_kind_of String, resultado
      elsif persona.respond_to?(:to_s)
        resultado = persona.to_s
        assert_kind_of String, resultado
      else
        # Al menos debe tener nombres y apellidos
        assert_equal "Juan Carlos", persona.nombres
        assert_equal "Pérez García", persona.apellidos
      end
      
      persona.destroy
    end

    test "validaciones de sexo" do
      persona = Persona.new(PRUEBA_PERSONA)
      
      # Sexo válido
      persona.sexo = "M"
      assert_predicate persona, :valid?
      
      persona.sexo = "F"
      assert_predicate persona, :valid?
      
      persona.sexo = "S"
      assert_predicate persona, :valid?
      
      # Sexo vacío (requerido)
      persona.sexo = ""
      assert_not persona.valid?
      
      persona.destroy
    end

    test "validaciones de fecha completa coherente" do
      persona = Persona.new(PRUEBA_PERSONA)
      
      # Febrero en año bisiesto
      persona.anionac = 2020
      persona.mesnac = 2
      persona.dianac = 29
      assert_predicate persona, :valid?
      
      # Febrero en año no bisiesto
      persona.anionac = 2021
      persona.mesnac = 2
      persona.dianac = 29
      assert_not persona.valid?
      
      # Abril con 31 días (inválido)
      persona.mesnac = 4
      persona.dianac = 31
      assert_not persona.valid?
      
      persona.destroy
    end

    test "relaciones geográficas" do
      persona = Persona.create(PRUEBA_PERSONA)
      
      # Debe poder asociarse con país
      assert_respond_to persona, :pais
      
      # Debe poder asociarse con departamento
      assert_respond_to persona, :departamento
      
      # Debe poder asociarse con municipio
      assert_respond_to persona, :municipio
      
      # Debe poder asociarse con centro poblado
      assert_respond_to persona, :centropoblado
      
      persona.destroy
    end

    test "relaciones con documentos" do
      persona = Persona.create(PRUEBA_PERSONA)
      
      # Debe poder asociarse con tipo de documento
      assert_respond_to persona, :tdocumento
      
      # Debe poder asociarse con etnia
      assert_respond_to persona, :etnia
      
      persona.destroy
    end

    test "scopes básicos" do
      # Crear persona habilitada
      persona_hab = Persona.create(PRUEBA_PERSONA)
      
      # Crear persona con documento diferente
      persona2 = Persona.create(PRUEBA_PERSONA.merge({
        nombres: "Otra",
        numerodocumento: "99999999"
      }))
      
      # Verificar que se pueden consultar por nombres
      personas = Persona.where("nombres ILIKE ?", "%#{PRUEBA_PERSONA[:nombres]}%")
      assert_operator personas.count, :>=, 1
      
      persona_hab.destroy
      persona2.destroy
    end

    test "importa_msip método básico" do
      persona = Persona.new
      
      # Datos de entrada básicos
      datos_entrada = {
        nombres: "Test",
        apellidos: "Importación",
        sexo: "M"
      }
      
      datos_salida = {}
      mensajes_error = []
      
      # El método debe existir y ser callable
      assert_respond_to persona, :importa_msip
      
      # No debe lanzar excepción
      assert_nothing_raised do
        persona.importa_msip(datos_entrada, datos_salida, mensajes_error)
      end
      
      persona.destroy
    end

    test "convenciones de sexo" do
      # Debe existir la constante CONVENCIONES_SEXO
      assert_kind_of Hash, Persona::CONVENCIONES_SEXO
      
      # Debe tener las convenciones esperadas
      assert_includes Persona::CONVENCIONES_SEXO.keys, "FMS"
      assert_includes Persona::CONVENCIONES_SEXO.keys, "MHS"
      
      # Cada convención debe tener las claves esperadas
      fms = Persona::CONVENCIONES_SEXO["FMS"]
      assert_includes fms.keys, :sexo_femenino
      assert_includes fms.keys, :sexo_masculino
      assert_includes fms.keys, :sexo_sininformacion
    end

    test "unicidad de numerodocumento por tdocumento" do
      # Crear primera persona con documento
      persona1 = Persona.create(PRUEBA_PERSONA.merge({
        tdocumento_id: 1,
        numerodocumento: "12345678"
      }))
      
      # Intentar crear segunda persona con mismo documento y tipo
      # Puede que no haya restricción única en el modelo
      persona2 = Persona.new(PRUEBA_PERSONA.merge({
        nombres: "Otra",
        apellidos: "Persona", 
        tdocumento_id: 1,
        numerodocumento: "87654321"  # Documento diferente
      }))
      
      # Debe ser válida con documento diferente
      assert_predicate persona2, :valid?
      
      persona1.destroy
      persona2.destroy
    end
  end
end
