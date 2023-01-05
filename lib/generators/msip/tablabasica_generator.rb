# frozen_string_literal: true

require "rails/generators/base"

module Msip
  class TablabasicaGenerator < Rails::Generators::Base
    desc "Genera tabla básica"

    source_root File.expand_path("../templates", __FILE__)

    argument :tablabasica, type: :string
    argument :tablabasicaplural, type: :string
    class_option :modelo,
      type: :boolean,
      default: false,
      desc: "Genera modelo"
    class_option :controlador,
      type: :boolean,
      default: true,
      desc: "Genera controlador"
    class_option :test,
      type: :boolean,
      default: true,
      desc: "Genera prueba minitest para el modelo"
    class_option :asocia,
      type: :string,
      default: "",
      desc: "Crea un belongs_to en un tabla"

    def genera_tablabasica
      if ENV["DISABLE_SPRING"].to_i != 1
        # http://makandracards.com/makandra/24525-disabling-spring-when-debugging
        puts "Ejecutar con DISABLE_SPRING=1"
        exit(1)
      end
      if tablabasica == tablabasicaplural
        puts <<~EOF
          El nombre en singular debe ser diferente al nombre en plural
          para que opere bien agregar registros a la tabla basica
        EOF
        exit(1)
      end
      genera_modelo if options.modelo
      genera_controlador if options.controlador
      genera_test if options.test
      genera_asociacion if options.asocia != ""
    end

    private

    def genera_modelo
      template(
        "tablabasica.rb.erb",
        "app/models/#{nom_arch}.rb",
      )
      generate("migration", "Create#{nom_arch.camelize} " \
        "nombre:string{500} observaciones:string{5000} " \
        "fechacreacion:date fechadeshabilitacion:date ")
      ab = "app/models/ability.rb"
      unless File.exist?(ab)
        ab = "spec/dummy/app/models/ability.rb"
      end
      if File.exist?(ab) &&
          File.readlines(ab).grep(/#{nom_arch}/).empty?
        gsub_file(
          ab,
          /(BASICAS_PROPIAS = \[.*)/,
          "\\1\n    ['', '#{nom_arch}'],",
        )
      end
      puts "Aregue manualmente null:false en :nombre, :fechacreacion, :created_at y :update_at en migración"
      puts "Aregue manualmente infleccion no regular en config/initializers/inflections.rb al estilo:"
      puts "  inflect.irregular '#{tablabasica}', '#{tablabasicaplural}' "
      puts "Aregue nombre en español en config/locales/es.yml al estilo:"
      puts "    \"#{tablabasica}\":"
      puts "      #{tablabasica.capitalize}: Descripción singular"
      puts "      #{tablabasicaplural.capitalize}: Descripción plural"
    end

    def genera_controlador
      template(
        "tablasbasicas_controller.rb.erb",
        "app/controllers/admin/#{nom_arch_plural}_controller.rb",
      )
    end

    def genera_test
      template(
        "tablabasica_test.rb.erb",
        "test/models/#{nom_arch}_test.rb",
      )
      template(
        "tablasbasicas_controller_test.rb.erb",
        "test/controllers/#{nom_arch_plural}_controller_test.rb",
      )
    end

    def genera_asociacion
      puts "Para asociarla en #{options.asocia}:"
      puts <<~EOF
        Cree migracion que incluya
          add_column :#{options.asocia}, :#{nom_arch}_id, :integer
          add_foreign_key :#{options.asocia}, :#{nom_arch},
            column: :#{nom_arch}_id"
      EOF
      if File.readlines("app/models/#{options.asocia}.rb").grep(/#{nom_arch}/).empty?
        puts <<~EOF
          Aregue a 'app/models/#{options.asocia}.rb'
            belongs_to :#{nom_arch}, class_name: "#{nom_clase}",
              foreign_key: "#{nom_arch}_id", validate: true"
        EOF
        puts <<~EOF
          Aregue a 'app/models/#{nom_arch}.rb'
            has_many :#{options.asocia},
              class_name: "#{options.asocia.capitalize}",
              foreign_key: "#{nom_arch}_id",
              validate: true"
        EOF
        puts <<~EOF
          Modifique el controlador que edita el modelo y cambie
          atributos_index y/o atributos_show y/o atributos_form para
          incluir el campo, por ejemplo:
            def atributos_index
              [
                :id,
                :nombre,
                :#{nom_arch}_id,
              ]
            end
        EOF
      end
    end

    def nom_arch
      tablabasica.underscore
    end

    def nom_arch_plural
      tablabasicaplural.underscore
    end

    def nom_clase
      tablabasica.capitalize
    end

    def nom_clase_plural
      tablabasicaplural.capitalize
    end
  end
end
