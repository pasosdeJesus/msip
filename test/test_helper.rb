# frozen_string_literal: true

require "zeitwerk"

ENV["RAILS_ENV"] ||= "test"

require "simplecov" # usará .simplecov de raiz
Zeitwerk::Loader.eager_load_all
require_relative "dummy/config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
  end
end

def verifica_formulario_usuario
  assert_select("#usuario_email[name=?]", "usuario[email]")
end

# En motores no funcionan fixtures como quedó documentado en
# https://github.com/rails/rails/issues/4971
# Es posible reusar datos de ejemplo de pruebas de modelos con:
#  require_relative '../../models/msip/grupoper_test'
#  require_relative '../../models/msip/orgsocial_test'
# Aunque se ejecutarán las pruebas de esos archivos nuevamente

# Nos parece más simple dejar los datos para pruebas en este archivo
# Y que cada prueba cree lo que necesite (posiblemente en setup)

PRUEBA_GRUPOPER = {
  id: 1,
  nombre: "grupoper1",
}

PRUEBA_CENTROPOBLADO = {
  id: 100000,
  nombre: "CENTROPOBLADO1",
  latitud: 1.5,
  longitud: 1.5,
  fechacreacion: "2014-08-04",
  fechadeshabilitacion: "2014-08-04",
  municipio_id: 1,
  tcentropoblado_id: "CAS",
}

PRUEBA_ANEXO = {
  descripcion: "x",
  created_at: "2014-11-11",
}

PRUEBA_BITACORA = {
  fecha: "2020-03-19",
  ip: "192.168.1.1",
  usuario_id: nil,
  url: "http://example.com/",
  params: "",
  modelo: "Msip::Persona",
  modelo_id: 1,
  operacion: "actualiza",
  detalle: "detalle",
}

PRUEBA_DEPARTAMENTO = {
  id: 1000,
  nombre: "DEPARTAMENTO1",
  latitud: 1.5,
  longitud: 1.5,
  fechacreacion: "2014-08-04",
  fechadeshabilitacion: nil,
  pais_id: 862,
}

PRUEBA_ESTADOSOL = {
  id: 101,
  nombre: "estado1",
  observaciones: "detalle",
  fechacreacion: "2022-06-22",
  fechadeshabilitacion: nil,
}

PRUEBA_ETIQUETA = {
  id: 1000,
  nombre: "Eti",
  observaciones: "O",
  fechacreacion: "2014-09-04",
  created_at: "2014-09-04",
}

PRUEBA_ETNIA = {
  id: 1001,
  nombre: "Etni",
  observaciones: "O",
  descripcion: "D",
  fechacreacion: "2024-02-19",
  created_at: "2024-02-19",
}

PRUEBA_FUENTEPRENSA = {
  id: 1000,
  nombre: "Fuenteprensa",
  fechacreacion: "2015-05-11",
  created_at: "2015-05-11",
}

PRUEBA_GRUPO = {
  id: 1000,
  nombre: "GRUPO1",
  fechacreacion: "2017-04-13",
}

PRUEBA_MUNICIPIO = {
  id: 100000,
  nombre: "MUNICIPIO1",
  latitud: 1.5,
  longitud: 1.5,
  fechacreacion: "2014-08-04",
  fechadeshabilitacion: "2014-08-04",
  departamento_id: 1,
}

PRUEBA_OFICINA = {
  id: 1000,
  nombre: "Ofi",
  observaciones: "Ofi",
  fechacreacion: "2015-04-16",
  created_at: "2015-04-16",
}

PRUEBA_ORGSOCIAL = {
  id: 1,
  grupoper_id: 1,
  created_at: "2021-08-27",
  updated_at: "2021-08-27",
}

PRUEBA_PAIS = {
  id: 1000,
  nombre: "PASI1",
  nombreiso_espanol: "PAIS1",
  latitud: 1.1,
  longitud_localizado: "1,2",
  fechacreacion: "2014-08-04",
}

PRUEBA_PERFILORGSOCIAL = {
  id: 1000,
  nombre: "PERFILORGSOCIAL1",
  fechacreacion: "2018-07-24",
}

PRUEBA_PERSONA = {
  nombres: "Nombres",
  apellidos: "Apellidos",
  etnia_id: 2,
  anionac: 1980,
  mesnac: 2,
  dianac: 2,
  sexo: "M",
  numerodocumento: "1061000000",
}

PRUEBA_TDOCUMENTO = {
  id: 1000,
  nombre: "Tdocumento",
  sigla: "TD",
  formatoregex: "[0-9]*",
  fechacreacion: "2014-09-22",
  created_at: "2014-09-22",
}

PRUEBA_TEMA = {
  id: 100,
  nombre: "tema",
  observaciones: "tema",
  nav_ini: "#111111",
  fechacreacion: "2022-12-29",
  created_at: "2022-12-29",
}

PRUEBA_TIPOORG = {
  nombre: "Tipoorg",
  fechacreacion: "2021-10-10",
  created_at: "2021-10-10",
}

PRUEBA_SECTORORGSOCIAL = {
  nombre: "Nombre sector",
  observaciones: "x",
  fechacreacion: "2018-07-20",
}

PRUEBA_SOLICITUD = {
  id: 1,
  usuario_id: 1,
  fecha: "2022-06-24",
  solicitud: "Especial",
  estadosol_id: 1,
  created_at: "2022-06-24",
  updated_at: "2022-06-24",
}

PRUEBA_TCENTROPOBLADO = {
  id: "x",
  nombre: "TX",
  fechacreacion: "2014-09-09",
  created_at: "2014-09-09",
}

PRUEBA_TRELACION = {
  id: "NN",
  nombre: "Trelacion",
  inverso: "NN",
  fechacreacion: "2014-09-09",
  created_at: "2014-09-09",
}

PRUEBA_TRIVALENTE = {
  nombre: "Trivalente",
  fechacreacion: "2019-08-17",
  created_at: "2019-08-17",
}

PRUEBA_TSITIO = {
  id: 1000,
  nombre: "Tsitio",
  fechacreacion: "2014-09-09",
  created_at: "2014-09-09",
}

PRUEBA_UBICACION = {
  tsitio_id: 1,
  pais_id: 862, # VENEZUELA
  departamento_id: 1, # DISTRITO CAPITAL
  municipio_id: 25, # BOLIVARIANO LIBERTADOR
  centropoblado_id: 217, # CARACAS
  created_at: "2014-11-06",
}

PRUEBA_UBICACIONPRE = {
  nombre: "BARRANCOMINAS / BARRANCOMINAS / GUAINÍA / COLOMBIA",
  pais_id: 170,
  departamento_id: 56,
  municipio_id: 594,
  centropoblado_id: 13064,
  lugar: nil,
  sitio: nil,
  tsitio_id: nil,
  latitud: nil,
  longitud: nil,
  created_at: "2021-12-08",
  updated_at: "2021-12-08",
  nombre_sin_pais: "BARRANCOMINAS / BARRANCOMINAS / GUAINÍA",
  fechacreacion: "2023-12-07"
}

PRUEBA_UBICACIONPRE2 = {
  pais_id: 100, # BULGARIA
  departamento_id: nil,
  municipio_id: nil,
  centropoblado_id: nil,
  lugar: "IMAGINA",
  nombre: "IMAGINA / BULGARIA",
  latitud: 0.1,
  longitud: 0.2,
  nombre_sin_pais: "IMAGINA",
  fechacreacion: "2023-12-07"
}

# Usuario administrador para ingresar y hacer pruebas
PRUEBA_USUARIO = {
  nusuario: "admin",
  password: "sjrven123",
  nombre: "admin",
  descripcion: "admin",
  rol: 1,
  idioma: "es_CO",
  email: "usuario1@localhost",
  encrypted_password: "$2a$10$uMAciEcJuUXDnpelfSH6He7BxW0yBeq6VMemlWc5xEl6NZRDYVA3G",
  sign_in_count: 0,
  fechacreacion: "2014-08-05",
  fechadeshabilitacion: nil,
}

# Usuario operador para ingresar y hacer pruebas
#
PRUEBA_USUARIO_OP = {
  nusuario: "operador",
  password: "sjrcol123",
  nombre: "operador",
  descripcion: "operador",
  rol: 5,
  idioma: "es_CO",
  email: "operador@localhost",
  encrypted_password: "$2a$10$uMAciEcJuUXDnpelfSH6He7BxW0yBeq6VMemlWc5xEl6NZRDYVA3G",
  sign_in_count: 0,
  fechacreacion: "2021-08-27",
  fechadeshabilitacion: nil,
}

PRUEBA_VEREDA = {
  id: 100000,
  nombre: "vereda",
  latitud: 1.5,
  longitud: 1.5,
  fechacreacion: "2014-08-04",
  fechadeshabilitacion: "2014-08-04",
  municipio_id: 1417,
}
