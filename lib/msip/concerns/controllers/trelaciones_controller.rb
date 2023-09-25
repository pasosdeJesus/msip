# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
    module TrelacionesController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Msip::Trelacion"
          end

          def set_trelacion
            @basica = Trelacion.find(params[:id])
          end

          def genclase
            "M"
          end

          def atributos_index
            [
              :id,
              :nombre,
              :inverso,
              :observaciones,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def atributos_form
            atributos_transf_habilitado
          end

          def validar_conjunto_inv_inv_identidad(validaciones)
            cp = Msip::Trelacion.joins(
              "JOIN msip_trelacion AS t2 ON t2.id=msip_trelacion.inverso"
            ).where("t2.inverso<>msip_trelacion.id")
            if cp.count > 0 
              validaciones << {
                titulo: "Inversa de inversa no es relación original",
                encabezado: ["Relación", "Inversa", "Inversa de la inversa"],
                cuerpo: cp.pluck(:id, :inverso, :'t2.inverso'),
                enlaces: cp.map {|tr| msip.edit_admin_trelacion_path(tr.id)}
              }
            end
          end

          # Validaciones al conjunto de trelaciones
          def validar_conjunto
            authorize! :validar, Msip::Trelacion
            # No manejamos filtro 

            @titulo_validar_conjunto = "Validaciones de tipos de relaciones familiares"
            @validaciones = []
            #debugger
            @url = msip.admin_trelaciones_validar_conjunto_path

            validar_conjunto_inv_inv_identidad(@validaciones)

            respond_to do |format|
                format.html { 
                  render 'msip/modelos/validar_conjunto', 
                layout: 'application' 
              }
              format.json { head :no_content }
              format.js   { head :no_content }
            end
          end

          def trelacion_params
            params.require(:trelacion).permit(*atributos_form)
          end

        end # included
      end
    end
  end
end
