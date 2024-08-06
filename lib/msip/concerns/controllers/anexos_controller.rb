# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module AnexosController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def descarga_anexo
            if !params[:id].nil?
              @anexo = Anexo.find(params[:id].to_i)
              ruta = @anexo.adjunto_file_name
              if !ruta.nil?
                # Idea para evitar inyeccion de https://www.ruby-forum.com/topic/124471
                n = format(
                  Msip.ruta_anexos.to_s + "/%d_%s",
                  @anexo.id.to_i,
                  File.basename(ruta),
                )
                logger.debug("Descargando #{n}")
                send_file(n, x_sendfile: true)
              else
                redirect_to(
                  Rails.configuration.relative_url_root,
                  alert: "Anexo sin ruta",
                )
              end
            else
              redirect_to(
                Rails.configuration.relative_url_root,
                alert: "Falta id",
              )
            end
          end

          def abre_anexo
            if !params[:id].nil?
              @anexo = Anexo.find(params[:id].to_i)
              ruta = @anexo.adjunto_file_name
              if !ruta.nil?
                # Idea para evitar inyeccion de https://www.ruby-forum.com/topic/124471
                n = format(
                  Msip.ruta_anexos.to_s + "/%d_%s",
                  @anexo.id.to_i,
                  File.basename(ruta),
                )
                logger.debug("Descargando #{n}")
                send_file(n, disposition: :inline)
              else
                redirect_to(
                  Rails.configuration.relative_url_root,
                  alert: "Anexo sin ruta",
                )
              end
            else
              redirect_to(
                Rails.configuration.relative_url_root,
                alert: "Falta id",
              )
            end
          end

          def mostrar_portada
            if !params[:id].nil?
              @anexo = Anexo.find(params[:id].to_i)
              ruta = @anexo.adjunto_file_name
              # ls = %x(ls -l #{Msip.ruta_anexos})
              pdfp = format(
                Msip.ruta_anexos.to_s + "/%d_%s",
                @anexo.id.to_i,
                File.basename(ruta),
              )
              ruta_im = ""
              if ruta.length > 5 && ruta[-4..-1] == ".pdf"
                orden = "pdftoppm -png -f 1 -l 1 \"#{pdfp}\" \"#{pdfp[..-5]}\""
                r = %x(#{orden})
                ruta_im = pdfp[..-5] + "-1.png"
                logger.debug("Descargando #{ruta_im}, r=#{r}")
                send_file(ruta_im, x_sendfile: true)
                nil
              else
                redirect_to(
                  Rails.configuration.relative_url_root,
                  alert: "Solo puede obtenerse portada de pdfs",
                )
              end
            else
              redirect_to(
                Rails.configuration.relative_url_root,
                alert: "Falta id",
              )
            end
          end
        end # included

        class_methods do

          def validar_existencia_archivo(validaciones)
            inexistentes = []
            Msip::Anexo.all.each do |a|
              n = format(
                Msip.ruta_anexos.to_s + "/%d_%s",
                a.id.to_i,
                a.adjunto_file_name
              )
              if !File.exist?(n)
                inexistentes << [a.id, a.adjunto_file_name]
              end
            end
            if inexistentes.count > 0
              validaciones << {
                titulo: "Anexos con archivo inexistente",
                encabezado: ["Código", "Archivo"],
                cuerpo: inexistentes
                #enlaces: inexistentes.map {|a| msip.edit_persona_path(p.id)}
              }
            end
          end

        end # class_methods

      end
    end
  end
end
