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

if ENV.fetch("SEMILLA_PEQ", "0") == "1"
  puts "grep1"
  `grep -v -e "INSERT INTO public.msip_centropoblado" -e "INSERT INTO public.msip_municipio" -e "INSERT INTO public.msip_vereda" -e "INSERT INTO public.msip_ubicacionpre" ../../db/datos-basicas.sql  > ../../db/datospeq-basicas.sql`
  puts "grep2"
  `grep "INSERT INTO public.msip_municipio.*\(1359," ../../db/datos-basicas.sql >> ../../db/datospeq-basicas.sql`
  puts "grep3"
  `grep "INSERT INTO public.msip_centropoblado.*, 1359," ../../db/datos-basicas.sql >> ../../db/datospeq-basicas.sql`
  puts "grep4"
  `grep "INSERT INTO public.msip_vereda.*, 1359," ../../db/datos-basicas.sql >> ../../db/datospeq-basicas.sql`
  puts "grep5"
  `grep -e "msip_ubicacionpre.* 'Colombia', 170, NULL, NULL, NULL" -e "msip_ubicacionpre.*, 170, 27, 1359," -e "msip_ubicacionpre.*, 170, 27, NULL,"  ../../db/datos-basicas.sql >> ../../db/datospeq-basicas.sql`
  puts "ls"
  puts `ls -l ../../db/`
  puts "cargando"
  Msip.carga_semillas_sql(conexion, "../..", :datospeq)
else
  Msip.carga_semillas_sql(conexion, "../..", :datos)
end

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
