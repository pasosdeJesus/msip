# frozen_string_literal: true

# http://stackoverflow.com/questions/1170148/run-rake-task-in-controller
require "English"
require "rake"
Rake::Task.clear # evitar cargar muchas veces en modo desarrollo
Rails.application.load_tasks

require "shellwords"

module Msip
  class Respaldo7zController < ApplicationController
    load_and_authorize_resource class: Msip::Respaldo7z

    def new
      @respaldo7z = Respaldo7z.new
      respond_to do |format|
        format.html { render(:new, layout: "application") }
      end
    end

    def create
      @respaldo7z = Respaldo7z.new(respaldo7z_params)
      respond_to do |format|
        if @respaldo7z.valid?
          Rake::Task["msip:vuelca"].reenable
          Rake::Task["msip:vuelca"].invoke
          archcopia = Msip::TareasrakeHelper.nombre_volcado(Msip.ruta_volcados)
          Rails.logger.debug { "archcopia=#{archcopia}" }
          # desturl = File.join( Msip.dir_respaldo7z, "#{archcopia}.7z")
          # dest = File.join( Rails.root, 'public', desturl)
          # Quitamos el .sql final de archcopia
          dest = "#{archcopia[0..-5]}.7z"
          FileUtils.rm_f(dest)
          tamanexos = %x(du -s #{Msip.ruta_anexos}).to_i
          Rails.logger.debug do
            "Tamaño de #{archcopia} es "\
              "#{File.size(Pathname.new(archcopia))}"
          end
          Rails.logger.debug { "Tamaño de anexos #{Msip.ruta_anexos} es #{tamanexos}" }
          lpi = []
          if ENV["DOAS_7Z"].to_i == 1
            lpi = ["doas"]
          end
          if tamanexos > 10000000
            Rails.logger.debug("Creando copia solo de base de datos")
            cmd = Shellwords.join(lpi + ["7z", "a", "-r",
                                         "-p#{@respaldo7z.clave7z}",
                                         dest, archcopia,])
          else
            Rails.logger.debug("Creando copia de base y anexos")
            cmd = Shellwords.join(lpi + ["7z", "a", "-r",
                                         "-p#{@respaldo7z.clave7z}",
                                         dest, archcopia, Msip.ruta_anexos,])
          end
          Rails.logger.debug { "cmd=#{cmd}" }
          cmd2 = "sh -c 'ulimit -c unlimited; whoami; #{cmd}'"
          Rails.logger.debug { "cmd2=#{cmd2}" }
          r = %x(#{cmd2})
          if $CHILD_STATUS.exitstatus == 0
            format.html do
              send_file(dest,
                type: "application/x-7z-compressed",
                disposition: "inline")
            end
          else
            format.html do
              flash.now[:error] = "Problemas generando con #{cmd}: #{r}"
              render(:new, layout: "application")
            end
          end
          # format.html { redirect_to main_app.root_path, 
          #   notice: "Respaldo creado, descarguelo de "\
          #     "<a href='#{desturl}'>desturl</a>" }
        else
          format.html { render(:new, layout: "application") }
        end
      end
    end

    private

    def respaldo7z_params
      params.require(:respaldo7z).permit(:clave7z, :clave7z_confirmation)
    end
  end
end
