# encoding: utf-8
# frozen_string_literal: true

require "active_support/core_ext/object/inclusion"
require "active_record"
require "colorize"

# require 'byebug'

require_relative "../../app/helpers/msip/tareasrake_helper"

namespace :msip do
  desc "Actualiza indices"
  task indices: :environment do
    connection = ActiveRecord::Base.connection
    puts "msip - indices"
    # Primero tablas basicas creadas en Rails
    # byebug
    ab = Ability.new
    tbn = ab.tablasbasicas - ab.basicas_id_noauto
    tbn.each do |t|
      nomt = Ability.tb_modelo(t)
      maxv = 100
      if ab.inisec_tb.keys.include?(nomt.to_sym)
        maxv = ab.inisec_tb[nomt.to_sym]
      end
      q = "SELECT setval('public.#{nomt}_id_seq', MAX(id)) FROM
          (SELECT #{maxv} as id UNION
            SELECT MAX(id) FROM public.#{Ability.tb_modelo(t)}) AS s;"
      # puts q
      connection.execute(q)
    end
    # Finalmente otras tablas no basicas pero con índices
    tb = ab.nobasicas_indice_seq_con_id
    tb.each do |t|
      # byebug
      connection.execute("
      SELECT setval('public.#{Ability.tb_modelo(t)}_id_seq', MAX(id)) FROM
          (SELECT 100 as id UNION
            SELECT MAX(id) FROM public.#{Ability.tb_modelo(t)}) AS s;")
    end
  end

  # De implementacion de structure:dump de rake y de
  # https://github.com/opdemand/puppet-modules/blob/master/rails/files/databases.rakeset
  desc "Vuelca tablas básicas de aplicación en orden"
  task vuelcabasicas: :environment do
    puts "msip - vuelcabasicas"
    Msip::TareasrakeHelper.asegura_varambiente_bd
    ab = Ability.new
    # Volcar primero superbasicas y otras en orden correcto
    tb = ab.tablasbasicas_prio +
      (ab.tablasbasicas - ab.tablasbasicas_prio)
    maq = "-h " + ENV.fetch("BD_SERVIDOR") + " -U " + ENV.fetch("BD_USUARIO")
    archt = Tempfile.create(["vb", ".sql"], nil)
    filename = "db/datos-basicas.sql"
    modobj = ""
    if Rails.application.class.to_s == "Dummy::Application" ||
        (Rails.application.class.respond_to?(:parent_name) &&
         Rails.application.class.parent_name == "Dummy")
      # en aplicaciones de prueba de motor el modulo objetivo es el del motor
      modobj = Ability.superclass.name.deconstantize
    end
    File.open(filename, "w") do |f|
      f << "-- Volcado de tablas basicas\n\n"
      tb.each do |t|
        printf "%s:%s - ", t[0], t[1]
        if t[0] == modobj
          command = "pg_dump --inserts --data-only --no-privileges " \
            "--no-owner --column-inserts --table=#{Ability.tb_modelo(t)} " \
            "#{maq} #{Shellwords.escape(ENV.fetch("BD_NOMBRE"))} " \
            "| sed -e \"s/SET lock_timeout = 0;//g\" > #{archt.to_path}"
          puts command.green
          raise "Error al volcar tabla #{Ability.tb_modelo(t)}" unless Kernel.system(command)

          inserto = false
          ordeno = false
          porord = []
          # Agrega volcado pero ordenando los INSERTS
          # (pues pg_dump reordena arbitrariamente haciendo que entre
          # un volcado y otro se vean diferencias con diff cuando no hay)
          # byebug
          File.open(archt.to_path, "r") do |ent|
            ent.each_line do |line|
              if line[0, 6] == "INSERT"
                inserto = true
                porord << line
              elsif !inserto || (inserto && ordeno)
                f << line
              else
                porord.sort!
                porord.each do |l|
                  f << l
                end
                ordeno = true
                f << line
              end
            end
          end
          unless ab.basicas_id_noauto.include?(t)
            nomt = Ability.tb_modelo(t)
            maxv = 100
            if ab.inisec_tb.keys.include?(nomt.to_sym)
              maxv = ab.inisec_tb[nomt.to_sym]
            end
            q = "SELECT pg_catalog.setval('public.#{nomt}_id_seq', " \
              "#{maxv}, true);\n"
            f << q
          end
        else
          puts "Saltando".red
        end
      end
    end
  end

  desc "Actualiza tablas básicas"
  task actbasicas: :environment do
    puts "msip - actbasicas"
    %x(
      pwd
      rails dbconsole <<-EOF
        \\i db/datos-basicas.sql
EOF
    )
  end

  desc "Vuelca base de datos completa"
  task vuelca: :environment do
    puts "msip - vuelca"
    Msip::TareasrakeHelper.asegura_varambiente_bd
    fecha = Time.zone.now.strftime("%Y-%m-%d")
    archcopia = Msip::TareasrakeHelper.nombre_volcado(Msip.ruta_volcados)
    unless Dir.exist?(File.dirname(archcopia))
      FileUtils.mkdir_p(File.dirname(archcopia))
    end
    %x(ls -l #{File.dirname(archcopia)})
    %x(ls -l #{File.dirname(archcopia, 2)})
    File.open(archcopia, "w") { |f| f << "-- Volcado del #{fecha}\n\n" }
    if ENV.fetch("DATABASE_URL", "").to_s != ""
      maq = "-d #{ENV.fetch("DATABASE_URL")} "
      puts "OJO maq=#{maq}"
    else
      maq = ""
      if ENV.fetch("BD_SERVIDOR").to_s != ""
        maq += "-h " + ENV.fetch("BD_SERVIDOR")
      end
      maq += " -U " + ENV.fetch("BD_USUARIO")
      maq += " #{Shellwords.escape(ENV.fetch("BD_NOMBRE"))} "
    end
    command = "pg_dump --encoding=UTF8 -cO --column-inserts " \
      "#{maq}  " \
      "> #{Shellwords.escape(archcopia)}"
    puts command
    raise "Error al volcar" unless Kernel.system(command)
  end # vuelca

  desc "Vuelca base de datos completa con un método rápido pero poco portable"
  task vuelcarapido: :environment do
    puts "msip - vuelcarapido"
    Msip::TareasrakeHelper.asegura_varambiente_bd
    fecha = Time.zone.now.strftime("%Y-%m-%d")
    archcopia = Msip::TareasrakeHelper.nombre_volcado(Msip.ruta_volcados, true)
    File.open(archcopia, "w") { |f| f << "-- Volcado rápido del #{fecha}\n\n" }
    maq = "-h " + ENV.fetch("BD_SERVIDOR") + " -U " + ENV.fetch("BD_USUARIO")
    command = "pg_dump --encoding=UTF8 " \
      "#{maq} " \
      "#{Shellwords.escape(ENV.fetch("BD_NOMBRE"))}  " \
      "> #{Shellwords.escape(archcopia)}"
    puts command
    raise "Error al volcar" unless Kernel.system(command)
  end # vuelcarapido

  desc "Restaura volcado"
  task restaura: :environment do |_t|
    arch = ENV.fetch("ARCH")
    puts "Restaurar #{arch} en ambiente"
    Msip::TareasrakeHelper.asegura_varambiente_bd
    maq = "-h " + ENV.fetch("BD_SERVIDOR") + " -U " + ENV.fetch("BD_USUARIO")
    command = "psql " \
      "#{maq} #{Shellwords.escape(ENV.fetch("BD_NOMBRE"))}  " \
      "-f #{Shellwords.escape(arch)}"
    puts command
    raise "Error al restaurar #{arch}" unless Kernel.system(command)
  end # restaura

  desc "Enlaza controladores de motores en app/javascript/controllers y actualiza index.js"
  task enlaces_motores: :environment do
    # No funciona desde la aplicación hacer `import` de controladores que
    # están en motores especificando la ruta del motor
    # porque intenta cargar dependencias desde la ruta del motor.
    # Nos ha funcionado con enlaces y usando `esbuild` con `--preserve-symlinks`
    # Si el motor `mi_motor` define el controlador `miControlador` en su
    # directorio `app/javascript/controllers`, al enlazarlo con esta tarea a una
    # aplicación, desde la aplicación se podrá referencia con
    # `mi-motor--mi-controlador`
    # Agregue a su `.gitignore` las rutas de los motores e.g
    # `app/javascript/controllers/mi_motor`

    # @param motor identificación del motor e.g msip
    # @param rutaf ruta fuente e.g
    #   ../../app/javascript/controllers o ../../app/assets/stylsheets/msip
    # @param rutad ruta destino e.g
    #   app/javascript/controllers/ o app/assets/styleshets a la que se 
    #   agrega motor app/javascript/controllers/msip
    # @param cgitignore  líneas de .gitignore
    # @param pora lista de rutas por agregar a .gitignore
    def enlaza(motor, rutaf, rutad, cgitignore, pora)
      puts "Enlazando de #{motor} en #{rutaf} a #{rutad}/#{motor}"
      rr = "#{rutad}/#{motor}"
      nr = File.join(FileUtils.pwd, rr)
      if File.exist?(nr)
        FileUtils.rm_rf(nr)
      end
      FileUtils.ln_sf(rutaf, nr)
      if cgitignore != [] && cgitignore.exclude?(rr)
        pora << rr
      end
    end

    cgitignore = []
    if File.exist?(".gitignore")
      cgitignore = File.read(".gitignore").split
    end
    pora = []
    # Si es aplicacíon de prueba de un motor enlazar los del motor
    motor = nil
    if Dir["../../*gemspec"].count == 1
      motor = Dir["../../*gemspec"][0][6..-9]
    end
    rutac = File.join(FileUtils.pwd, "../../app/javascript/controllers")
    if motor && Dir.exist?(rutac)
      enlaza(
        motor,
        rutac,
        "app/javascript/controllers",
        cgitignore,
        pora,
      )
    end
    rutac = File.join(FileUtils.pwd, "../../app/assets/stylesheets")
    if motor && Dir.exist?(rutac)
      enlaza(
        motor,
        rutac,
        "app/assets/stylesheets",
        cgitignore,
        pora,
        )
    end

    Gem::Specification.find_all.each do |s|
      rutac = File.join(s.gem_dir, "/app/javascript/controllers")
      if Dir.exist?(rutac)
        enlaza(s.name, rutac, "app/javascript/controllers", cgitignore, pora)
      end
      rutac = File.join(s.gem_dir, "/app/assets/stylesheets")
      if Dir.exist?(rutac)
        enlaza(s.name, rutac, "app/assets/stylesheets", cgitignore, pora)
      end
    end
    puts "Ejecutando stimulus:manifest:update"
    Rake::Task["stimulus:manifest:update"].invoke
    unless pora.empty?
      puts "\n===================================="
      puts "Se recomienda añadir a su .gitignore:"
      puts pora.join('\n')
    end
  end

  desc "Mezcla reporte de cobertura de pruebas con los de pruebas del sistema"
  task :reporteregresion do
    require "simplecov"
    SimpleCov.formatters = [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::SimpleFormatter,
    ]

    SimpleCov.coverage_dir("coverage")

    dirs = Dir["cobertura-unitarias/.resultset.json",
      "cobertura-sistema/.resultset.json"]
    if File.exist?("test/dummy/config/application.rb")
      dirs = Dir["cobertura-unitarias/.resultset.json",
        "test/dummy/cobertura-sistema/.resultset.json"]
    end
    SimpleCov.collate(dirs)
  end
end
