# frozen_string_literal: true

require_relative "../test_helper"

class UsuarioTest < ActiveSupport::TestCase
  test "valido" do
    usuario = Usuario.create(PRUEBA_USUARIO)

    assert_predicate usuario, :valid?
    usuario.destroy
  end

  test "no valido" do
    usuario = Usuario.new(PRUEBA_USUARIO)
    usuario.nusuario = ""

    assert_not usuario.valid?
    usuario.destroy
  end

  test "validaciones de nusuario" do
    usuario = Usuario.new(PRUEBA_USUARIO)
    
    # Formato válido
    usuario.nusuario = "admin_123"
    assert_predicate usuario, :valid?
    
    # Formato inválido con espacios
    usuario.nusuario = "admin 123"
    assert_not usuario.valid?
    
    # Formato inválido con caracteres especiales
    usuario.nusuario = "admin@123"
    assert_not usuario.valid?
    
    # Formato válido con guión
    usuario.nusuario = "admin-123"
    assert_predicate usuario, :valid?
    
    # Longitud máxima
    usuario.nusuario = "a" * (Msip.longitud_nusuario + 1)
    assert_not usuario.valid?
    
    usuario.destroy
  end

  test "validaciones de email" do
    usuario = Usuario.new(PRUEBA_USUARIO)
    
    # Email válido
    usuario.email = "test@example.com"
    assert_predicate usuario, :valid?
    
    # Email vacío (Rails/Devise puede requerir email)
    usuario.email = ""
    assert_not usuario.valid?
    
    # Email muy largo
    usuario.email = "a" * 250 + "@example.com"
    assert_not usuario.valid?
    
    usuario.destroy
  end

  test "validaciones de fechas" do
    usuario = Usuario.new(PRUEBA_USUARIO)
    
    # Fecha de creación muy antigua
    usuario.fechacreacion = "1999-01-01"
    assert_not usuario.valid?
    
    # Fecha de creación válida
    usuario.fechacreacion = "2020-01-01"
    assert_predicate usuario, :valid?
    
    # Fecha de deshabilitación anterior a creación
    usuario.fechadeshabilitacion = "2019-01-01"
    assert_not usuario.valid?
    
    # Fecha de deshabilitación posterior a creación
    usuario.fechadeshabilitacion = "2021-01-01"
    assert_predicate usuario, :valid?
    
    usuario.destroy
  end

  test "validaciones de password" do
    usuario = Usuario.new(PRUEBA_USUARIO)
    
    # Password muy largo
    usuario.password = "a" * 65
    assert_not usuario.valid?
    
    # Password válido
    usuario.password = "password123"
    assert_predicate usuario, :valid?
    
    usuario.destroy
  end

  test "validaciones de otros campos" do
    usuario = Usuario.new(PRUEBA_USUARIO)
    
    # Descripción muy larga
    usuario.descripcion = "a" * 51
    assert_not usuario.valid?
    
    # Idioma vacío
    usuario.idioma = ""
    assert_not usuario.valid?
    
    # Idioma muy largo
    usuario.idioma = "es_CO_X"
    assert_not usuario.valid?
    
    # Rol vacío
    usuario.rol = nil
    assert_not usuario.valid?
    
    usuario.destroy
  end

  test "presenta_nombre" do
    usuario = Usuario.new(PRUEBA_USUARIO)
    
    # Con nombre
    usuario.nusuario = "admin"
    usuario.nombre = "Administrador"
    assert_equal "admin - Administrador", usuario.presenta_nombre
    
    # Sin nombre
    usuario.nombre = nil
    assert_equal "admin", usuario.presenta_nombre
    
    usuario.destroy
  end

  test "uniqueness validations" do
    usuario1 = Usuario.create(PRUEBA_USUARIO)
    
    # Otro usuario con mismo nusuario
    usuario2 = Usuario.new(PRUEBA_USUARIO)
    usuario2.email = "otro@example.com"
    assert_not usuario2.valid?
    
    # Otro usuario con mismo email
    usuario3 = Usuario.new(PRUEBA_USUARIO)
    usuario3.nusuario = "otrousuario"
    assert_not usuario3.valid?
    
    usuario1.destroy
    usuario2.destroy
    usuario3.destroy
  end

  test "scopes" do
    # Crear usuario habilitado
    usuario_hab = Usuario.create(PRUEBA_USUARIO)
    
    # Crear usuario deshabilitado
    usuario_des = Usuario.create(PRUEBA_USUARIO.merge({
      nusuario: "deshabilitado",
      email: "des@example.com",
      fechadeshabilitacion: "2023-01-01"
    }))
    
    # Scope habilitados debe incluir solo el habilitado
    habilitados = Usuario.habilitados
    assert_includes habilitados, usuario_hab
    assert_not_includes habilitados, usuario_des
    
    usuario_hab.destroy
    usuario_des.destroy
  end

  test "associations" do
    usuario = Usuario.create(PRUEBA_USUARIO)
    
    # Debe poder asociarse con tema
    assert_respond_to usuario, :tema
    
    # Debe poder asociarse con grupos
    assert_respond_to usuario, :grupo
    
    usuario.destroy
  end
end
