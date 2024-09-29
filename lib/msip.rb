# frozen_string_literal: true

require "devise"
require "msip/engine"

# @!macro msip
#   Motor con lo escencial de un sistema de información al estilo Pasos de 
#   Jesús: (1) personas y relaciones entre personas, (2) grupos de personas 
#   y organizaciones sociales, (3) control de acceso a la aplicación, 
#   (4) ubicaciones geográficas, (5) temas y (6) tablas básicas. 
module Msip
  # Carga un archivo con semillas SQL de un motor, ruta o app
  # @param conexion [Object] Tipicamente ActiveRecord::Base.connection()
  # @param motor [String] motor del cual cargar, o cadena con ruta
  #   o nil para que sea de aplicación
  # @param tipoarchivo [String] 'cambios' o 'datos' para indicar si se carga
  #     cambios-basica.sql o datos-basica.sql. El primero debería tener cambios
  #     a tablas básicas de motor del cual desciende directamente.
  #     El segundo debería tener nuevos datos para las tablas básicas.
  # @param patexcluye [Pattern] Excluir lineas que cumplan el patrón
  #
  # @return [void] Si el archivo existe lo ejecuta
  def self.carga_semillas_sql(conexion, motor, tipoarchivo, patexcluye = nil)
    if tipoarchivo.to_s != "datos" && tipoarchivo.to_s != "cambios"
      raise "Las semillas solo pueden ser cambios o datos"
    end

    if motor
      if Gem.loaded_specs[motor.to_s]
        motor = Gem.loaded_specs[motor.to_s].full_gem_path + "/"
      else # Ruta
        motor = motor.to_s + "/"
        if !File.exist?("#{motor}db/#{tipoarchivo}-basicas.sql") &&
            motor == "../../" && ENV["RAILS_ENV"] == "test"
          # En motores se ejecutan pruebas desde directorio del motor
          # y no desde test/dummy
          motor = ""
        end
      end
    else
      motor = "" # Aplicacion
    end
    n = "#{motor}db/#{tipoarchivo}-basicas.sql"
    if File.exist?(n)
      l = File.readlines(n)
      if patexcluye
        l = l.select { |u| !u[patexcluye] }
      end
      conexion.execute(l.join("\n"))
    end
  end

  # PostgreSQL

  # Determina si existe una secuencia
  # Considerar https://rubygems.org/gems/activerecord-postgresql-extensions
  # (aunque parece no proveer algo como primary_key_exists?)
  # http://stackoverflow.com/questions/11905868/Check-if-sequence-exists-in-Postgres-plpgsql/11919600#11919600
  def self.existe_secuencia?(conexion, nombre)
    cs = conexion.select_all("SELECT c.relkind
      FROM   pg_catalog.pg_namespace n
      JOIN   pg_catalog.pg_class c ON c.relnamespace = n.oid
      WHERE  n.nspname = current_schema
      AND c.relname = '#{nombre}'
      AND c.relkind = 'S'")
    return true if cs.count > 0

    false
  end

  # Renombra una secuncia
  # @return bool true sii puede renombrar
  def self.renombra_secuencia(conexion, anterior, nuevo)
    if Msip.existe_secuencia?(conexion, anterior) &&
        !Msip.existe_secuencia?(conexion, nuevo)
      conexion.execute(<<-SQL.squish)
        ALTER SEQUENCE #{anterior}
          RENAME TO #{nuevo};
      SQL
      return true
    end
    false
  end
end
