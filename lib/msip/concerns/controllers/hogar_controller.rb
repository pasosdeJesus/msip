# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module HogarController
        extend ActiveSupport::Concern

        included do
          def tablasbasicas
            @ntablas = {}
            @ntablasor = Msip::ModeloHelper.lista_tablas_basicas(
              current_ability, @ntablas
            )
            render(layout: "application")
          end

          def verificarutas
            em = ""
            unless File.directory?(Msip.ruta_anexos)
              em += "No existe ruta de anexos '#{Msip.ruta_anexos}'. "
            end
            unless File.directory?(Msip.ruta_volcados)
              em += "No existe ruta de volcados '#{Msip.ruta_volcados}'. "
            end
            if em != ""
              puts em
              flash[:error] = em
            end
          end

          def index
            if current_usuario
              authorize!(:read, Msip::Pais)
            end
            verificarutas
            render(layout: "application")
          end

          def acercade
            verificarutas
            render(layout: "application")
          end

          def espacioenplan
            1000000000
          end

          def espacio
            verificarutas
            @espacioenplan = espacioenplan
            render(layout: "application")
          end

          def ayuda_controldeacceso
            verificarutas
            render(layout: "application")
          end
        end # included
      end
    end
  end
end
