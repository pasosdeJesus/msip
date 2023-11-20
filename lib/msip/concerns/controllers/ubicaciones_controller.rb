# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module UbicacionesController
        extend ActiveSupport::Concern

        included do
          def reterror
            respond_to do |format|
              format.html { render(action: "error") }
              format.json do
                render(json: @ubicacion.errors, status: :unprocessable_entity)
              end
            end
          end

          def nuevo_completa_ubicacion
          end

          # Crea un nuevo registro para el caso que recibe por parametro
          # params[:caso_id].  Pone valores simples en los campos requeridos
          def nuevo
            if !params[:caso_id] || params[:caso_id] == ""
              respond_to do |format|
                format.html { render(inline: "Falta identificacion del caso") }
              end
              return
            end
            @ubicacion = Ubicacion.new
            nuevo_completa_ubicacion
            @ubicacion.pais_id = 170
            unless @ubicacion.save(validate: false)
              return reterror
            end

            respond_to do |format|
              format.js { render(text: @ubicacion.id.to_s) }
              format.json { render(json: @ubicacion.id.to_s, status: :created) }
              format.html { render(inline: @ubicacion.id.to_s) }
            end
          end

          def update
            unless @caso.update(ubicacion_params)
              return reterror
            end

            respond_to do |format|
              format.js { render(text: @ubicacion.id.to_s) }
              format.json { render(json: @ubicacion.id.to_s, status: :updated) }
              format.html { render(inline: @ubicacion.id.to_s) }
            end
          end

          def ubicacion_params
            params.require(:ubicacion).permit(
              :id,
              :pais_id,
              :departamento_id,
              :municipio_id,
              :centropoblado_id,
              :lugar,
              :sitio,
              :latitud,
              :longitud,
              :tsitio_id,
              :_destroy,
            )
          end
        end
      end
    end
  end
end
