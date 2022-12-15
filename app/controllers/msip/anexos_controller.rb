# frozen_string_literal: true

module Msip
  class AnexosController < ApplicationController
    load_and_authorize_resource class: Msip::Anexo

    def descarga_anexo
      unless params[:id].nil?
        @anexo = Anexo.find(params[:id].to_i)
        ruta = @anexo.adjunto_file_name
        if !ruta.nil?
          # Idea para evitar inyeccion de https://www.ruby-forum.com/topic/124471
          n = format(Msip.ruta_anexos.to_s + "/%d_%s", @anexo.id.to_i,
            File.basename(ruta))
          logger.debug("Descargando #{n}")
          send_file(n, x_sendfile: true)
        else
          redirect_to(usuarios_url)
        end
      end
    end

    def abre_anexo
      unless params[:id].nil?
        @anexo = Anexo.find(params[:id].to_i)
        ruta = @anexo.adjunto_file_name
        if !ruta.nil?
          # Idea para evitar inyeccion de https://www.ruby-forum.com/topic/124471
          n = format(Sip.ruta_anexos.to_s + "/%d_%s", @anexo.id.to_i,
            File.basename(ruta))
          logger.debug("Descargando #{n}")
          send_file(n, disposition: :inline)
        else
          redirect_to(usuarios_url)
        end
      end
    end

    def mostrar_portada
      unless params[:id].nil?
        @anexo = Anexo.find(params[:id].to_i)
        ruta = @anexo.adjunto_file_name
        pdfp = format(Msip.ruta_anexos.to_s + "/%d_%s", @anexo.id.to_i,
          File.basename(ruta))
        if ruta.length > 5 && ruta[-4..-1] == ".pdf"
          p(%x(pdftoppm -png -f 1 -l 1 "#{pdfp}" "#{pdfp[..-5]}"))
          ruta_im = pdfp[..-5] + "-1.png"
        end
        logger.debug("Descargando #{ruta_im}")
        send_file(ruta_im, x_sendfile: true)
      end
    end
  end
end
