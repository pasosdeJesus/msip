# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module PersonaTrelacionesController
        extend ActiveSupport::Concern

        included do

          def create
          end

          def destroy
            render :destroy, layout: nil
          end

          def update
            authorize! :update, Msip::Persona
            if !params || !params[:persona] || 
                !params[:persona][:id] ||
                params[:persona][:id].to_i == 0 ||
                !params[:persona][:persona_trelacion1_attributes] 
              return
            end
            p1id = params[:persona][:id].to_i
            if Msip::Persona.where(id: p1id).count ==0
              return 
            end

            p2id = nil
            prim = params[:persona][:persona_trelacion1_attributes].each {
              |l,v| if v && v[:personados_attributes] && 
                v[:personados_attributes][:id] &&
                v[:personados_attributes][:id].to_i > 0 &&
                v[:personados_attributes][:nombres] &&
                v[:personados_attributes][:nombres] == ""
                p2id = v[:personados_attributes][:id].to_i
              end
            }
            if p2id.nil?
              return
            end
            if Msip::Persona.where(id: p2id).count ==0
              return 
            end

            ntr = Msip::PersonaTrelacion.create(persona1: p1id, persona2: p2id)
            if !ntr.valid?
              return
            end
            @persona = Msip::Persona.new( persona_trelacion1: [ntr])
          end

          private

          def preparar_persona
            @registro = @persona = Msip::Persona.new(
              persona_trelacion1: [Msip::PersonaTrelacion.new]
            )
          end

        end # included

      end
    end
  end
end
