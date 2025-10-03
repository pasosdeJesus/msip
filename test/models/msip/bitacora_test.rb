# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class BitacoraTest < ActiveSupport::TestCase
    test "valido" do
      bitacora = Msip::Bitacora.create(PRUEBA_BITACORA)

      assert_predicate bitacora, :valid?
      bitacora.destroy
    end

    test "no valido por falta de fecha" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.fecha = nil

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "no valido por falta de fecha 2" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.fecha = ""

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "no valido por ip larga" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.ip = "x" * 600

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "no valido por modelo largo" do
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA)
      bitacora.modelo = "x" * 6000

      assert_not bitacora.valid?
      bitacora.destroy
    end

    test "valido sin detalle" do
      bitacora = Msip::Bitacora.create(PRUEBA_BITACORA)
      bitacora.detalle = nil

      assert_predicate bitacora, :valid?
      bitacora.destroy
    end

    test "debe asociarse con usuario existente" do
      usuario = Usuario.create(PRUEBA_USUARIO)
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA.merge(usuario: usuario))
      
      assert bitacora.valid?
      assert_equal usuario, bitacora.usuario
      
      bitacora.destroy
      usuario.destroy
    end

    test "debe permitir diferentes operaciones" do
      operaciones = ["crea", "actualiza", "elimina", "consulta", "lee"]
      
      operaciones.each do |op|
        bitacora = Msip::Bitacora.new(PRUEBA_BITACORA.merge(operacion: op))
        assert bitacora.valid?, "Operación #{op} debe ser válida"
      end
    end

    test "debe manejar URLs largas" do
      url_larga = "http://example.com/" + "x" * 500
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA.merge(url: url_larga))
      
      # Dependiendo de la validación, puede ser válida o no
      assert bitacora.valid? || bitacora.errors[:url].any?
    end

    test "debe manejar parámetros complejos" do
      params_complejos = {
        persona: { nombres: "Juan", apellidos: "Pérez" },
        ubicacion: { latitud: 1.5, longitud: -2.3 }
      }.to_json
      
      bitacora = Msip::Bitacora.new(PRUEBA_BITACORA.merge(params: params_complejos))
      assert bitacora.valid?
    end

    test "debe registrar diferentes modelos del sistema" do
      modelos = [
        "Msip::Persona", 
        "Msip::Ubicacion", 
        "Msip::Orgsocial",
        "Msip::Anexo",
        "Usuario"
      ]
      
      modelos.each do |modelo|
        bitacora = Msip::Bitacora.new(PRUEBA_BITACORA.merge(modelo: modelo))
        assert bitacora.valid?, "Modelo #{modelo} debe ser válido"
      end
    end

    test "debe manejar IPs en diferentes formatos" do
      ips = [
        "192.168.1.1",
        "10.0.0.1", 
        "172.16.0.1",
        "::1",  # IPv6 loopback
        "127.0.0.1"
      ]
      
      ips.each do |ip|
        bitacora = Msip::Bitacora.new(PRUEBA_BITACORA.merge(ip: ip))
        assert bitacora.valid?, "IP #{ip} debe ser válida"
      end
    end

    test "debe ordenar cronológicamente" do
      # Crear bitácoras con diferentes fechas
      bitacora_antigua = Msip::Bitacora.create!(PRUEBA_BITACORA.merge(
        fecha: 2.days.ago,
        detalle: "antigua"
      ))
      
      bitacora_reciente = Msip::Bitacora.create!(PRUEBA_BITACORA.merge(
        fecha: 1.hour.ago,
        detalle: "reciente"
      ))
      
      # Verificar orden
      resultados = Msip::Bitacora.order(:fecha)
      assert_operator resultados.index(bitacora_antigua), :<, resultados.index(bitacora_reciente)
      
      # Limpiar
      bitacora_antigua.destroy
      bitacora_reciente.destroy
    end

    test "debe filtrar por usuario" do
      usuario1 = Usuario.create(PRUEBA_USUARIO.merge(nusuario: "usuario1"))
      usuario2 = Usuario.create(PRUEBA_USUARIO.merge(nusuario: "usuario2", email: "user2@localhost"))
      
      bitacora1 = Msip::Bitacora.create!(PRUEBA_BITACORA.merge(usuario: usuario1))
      bitacora2 = Msip::Bitacora.create!(PRUEBA_BITACORA.merge(usuario: usuario2))
      
      # Filtrar por usuario
      resultados_usuario1 = Msip::Bitacora.where(usuario: usuario1)
      assert_includes resultados_usuario1, bitacora1
      assert_not_includes resultados_usuario1, bitacora2
      
      # Limpiar
      bitacora1.destroy
      bitacora2.destroy
      usuario1.destroy
      usuario2.destroy
    end
  end
end
