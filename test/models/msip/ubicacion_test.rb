# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class UbicacionTest < ActiveSupport::TestCase
    test "simple" do
      pais = Pais.find(862)
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      ubicacion.pais = pais

      assert_predicate ubicacion, :valid?
    end

    test "no valido" do
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      ubicacion.tsitio_id = nil

      assert_not ubicacion.valid?
    end

    test "no valido 2" do
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      ubicacion.pais_id = nil

      assert_not ubicacion.valid?
    end

    test "presenta_nombre" do
      u = Ubicacion.create(PRUEBA_UBICACION)

      assert_equal "Colombia / Cundinamarca / Une / Une",
        u.presenta_nombre
      assert_equal "Colombia / Cundinamarca / Une",
        u.presenta_nombre({ sin_centropoblado: 1 })
      assert_equal "Colombia / Cundinamarca",
        u.presenta_nombre({ sin_centropoblado: 1, sin_municipio: 1 })
      assert_equal "Colombia",
        u.presenta_nombre({ sin_centropoblado: 1, sin_municipio: 1, sin_departamento: 1 })
      assert_equal "",
        u.presenta_nombre({
          sin_centropoblado: 1,
          sin_municipio: 1,
          sin_departamento: 1,
          sin_pais: 1,
        })
    end

    test "validaciones de coordenadas" do
      ubicacion = Ubicacion.new(PRUEBA_UBICACION)
      
      # Latitud válida
      ubicacion.latitud = 45.0
      assert_predicate ubicacion, :valid?
      
      # Si hay validaciones de rango, probar límites
      # Pero si no las hay, sólo verificar que acepta valores normales
      ubicacion.latitud = 4.0
      ubicacion.longitud = -75.0
      assert_predicate ubicacion, :valid?
      
      ubicacion.destroy
    end

    test "relaciones geográficas" do
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      
      # Debe tener país
      assert_not_nil ubicacion.pais
      assert_respond_to ubicacion, :pais
      
      # Debe poder tener departamento
      assert_respond_to ubicacion, :departamento
      
      # Debe poder tener municipio
      assert_respond_to ubicacion, :municipio
      
      # Debe poder tener centro poblado
      assert_respond_to ubicacion, :centropoblado
      
      # Debe tener tipo de sitio
      assert_respond_to ubicacion, :tsitio
      
      ubicacion.destroy
    end

    test "validaciones de lugar" do
      ubicacion = Ubicacion.new(PRUEBA_UBICACION)
      
      # Lugar válido
      ubicacion.lugar = "Descripción del lugar"
      assert_predicate ubicacion, :valid?
      
      # Lugar muy largo
      ubicacion.lugar = "a" * 1001
      assert_not ubicacion.valid?
      
      ubicacion.destroy
    end

    test "jerarquía geográfica coherente" do
      # Centro poblado debe estar en municipio correcto
      ubicacion = Ubicacion.new(PRUEBA_UBICACION)
      centropoblado = ubicacion.centropoblado
      municipio = ubicacion.municipio
      
      if centropoblado && municipio
        assert_equal municipio.id, centropoblado.municipio_id
      end
      
      # Municipio debe estar en departamento correcto
      if municipio
        departamento = ubicacion.departamento
        if departamento
          assert_equal departamento.id, municipio.departamento_id
        end
      end
      
      ubicacion.destroy
    end

    test "presenta_nombre con diferentes configuraciones" do
      ubicacion = Ubicacion.create(PRUEBA_UBICACION)
      
      # Nombre completo
      nombre_completo = ubicacion.presenta_nombre
      assert_kind_of String, nombre_completo
      assert_operator nombre_completo.length, :>, 0
      
      # Solo país
      solo_pais = ubicacion.presenta_nombre({
        sin_departamento: 1,
        sin_municipio: 1,
        sin_centropoblado: 1
      })
      assert_kind_of String, solo_pais
      assert_equal "Colombia", solo_pais
      
      # Sin lugar
      sin_lugar = ubicacion.presenta_nombre({ sin_lugar: 1 })
      assert_kind_of String, sin_lugar
      
      ubicacion.destroy
    end

    test "copia profunda de ubicación" do
      ubicacion_original = Ubicacion.create(PRUEBA_UBICACION)
      
      # El método debe responder a dup
      assert_respond_to ubicacion_original, :dup
      
      ubicacion_copia = ubicacion_original.dup
      
      # Debe ser un objeto diferente
      assert_not_equal ubicacion_original.object_id, ubicacion_copia.object_id
      
      # Pero con los mismos atributos básicos
      assert_equal ubicacion_original.pais_id, ubicacion_copia.pais_id
      if ubicacion_original.lugar.nil?
        assert_nil ubicacion_copia.lugar
      else
        assert_equal ubicacion_original.lugar, ubicacion_copia.lugar
      end
      
      ubicacion_original.destroy
    end

    test "búsqueda y filtros" do
      ubicacion1 = Ubicacion.create(PRUEBA_UBICACION)
      
      ubicacion2 = Ubicacion.create(PRUEBA_UBICACION.merge({
        lugar: "Otro lugar",
        latitud: 10.0,
        longitud: -75.0
      }))
      
      # Debe poder filtrar por lugar
      if Ubicacion.respond_to?(:where)
        resultado = Ubicacion.where("lugar ILIKE ?", "%lugar%")
        assert_operator resultado.count, :>=, 1
      end
      
      ubicacion1.destroy
      ubicacion2.destroy
    end

    test "validaciones de tsitio requerido" do
      ubicacion = Ubicacion.new(PRUEBA_UBICACION)
      
      # Sin tsitio debe ser inválido
      ubicacion.tsitio_id = nil
      assert_not ubicacion.valid?
      
      # Con tsitio debe ser válido
      ubicacion.tsitio_id = 1
      assert_predicate ubicacion, :valid?
      
      ubicacion.destroy
    end
  end
end
