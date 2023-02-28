# frozen_string_literal: true

# Este archivo debe contener todas las creaciones de registros
# necesarias para alimentar la base de datos con sus valores por defecto.
# Los datos puede cargarse con la tarea rake db:seed (o creados junto
# con la tarea db:setup).
#
# Ejemplos:
#
#   ciudades = Ciudad.create([{ name: 'Chia' }, { name: 'Cúcuta' }])
#   Alcalde.create(name: 'Emanuel', ciudad: ciudades.first)

conexion = ActiveRecord::Base.connection

Msip.carga_semillas_sql(conexion, "../..", :datos)

# usuario msip, clave msip
conexion.execute("INSERT INTO public.usuario
	(nusuario, email, encrypted_password, password,
  fechacreacion, created_at, updated_at, rol)
	VALUES ('msip', 'msip@localhost',
  '$2a$10$WphwnqY9mO/vGcIEUuWVquetUqBd9kqcbnUFmxpbPuYRUs8FwdArW',
	'', '2014-08-14', '2014-08-14', '2014-08-14', 1);")

# usuario operador, clave operador
conexion.execute("INSERT INTO public.usuario
	(nusuario, email, encrypted_password, password,
  fechacreacion, created_at, updated_at, rol)
	VALUES ('operador', 'operador@localhost',
  '$2a$10$G6hwcqfRQMTWY3YhroTgOO7k4XgZiOxGi/jpoetgzCjUw1VHoLujC',
	'', '2023-02-27', '2023-02-27', '2023-02-27', 5);")
