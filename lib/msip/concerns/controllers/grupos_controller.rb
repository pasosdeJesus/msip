# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module GruposController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          before_action :set_grupo,
            only: [:show, :edit, :update, :destroy]

          def clase
            "Msip::Grupo"
          end

          def atributos_index
            [
              "id",
              "nombre",
            ] +
              [usuario_ids: []] +
              [
                "observaciones",
                "fechacreacion_localizada",
                "fechadeshabilitacion_localizada",
              ]
          end

          def atributos_form
            r = ["nombre"]
            # No perite agregar miembros a grupos totalmente nuevos
            # primero debe crearse
            if @registro.nil? || @registro.respond_to?("id")
              # En new y edit @registro no es nil
              # En create y update @registro es nil
              r += [usuario_ids: []]
            end
            r += [
              "observaciones",
              "fechacreacion",
              "fechadeshabilitacion",
            ]
            r
          end

          def genclase
            "M"
          end

          def set_grupo
            @registro = @basica = Msip::Grupo.find(params[:id])
          end

          def grupo_params
            params.require(:grupo).permit(*atributos_form)
          end
        end # include
      end
    end
  end
end
