# frozen_string_literal: true

module Msip
  module Admin
    class ClasesController < BasicasController
      before_action :set_clase, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Msip::Clase, except: [:tipo_clase]

      def clase
        "Msip::Clase"
      end

      def index
        c = nil
        if params[:municipio_id] && params[:municipio_id].to_i > 0
          idmun = params[:municipio_id].to_i
          c = Msip::Clase.where(
            fechadeshabilitacion: nil,
            municipio_id: idmun,
          ).all
        end
        Msip::Municipio.conf_presenta_nombre_con_departamento = true
        super(c)
      end

      def set_clase
        @basica = Clase.find(params[:id])
      end

      def tipo_clase
        id = params[:id].to_i
        if id > 0
          tclase_id = Msip::Clase.find(id).tclase_id
          nombre_tipo = Msip::Tclase.find(tclase_id).nombre
          render(json: { nombre: nombre_tipo })
        else
          render(json: { nombre: "" })
        end
        nil
      end

      def atributos_index
        [
          :id,
          :nombre,
          :pais,
          :municipio_id,
          :clalocal_cod,
          :tclase_id,
          :latitud,
          :longitud,
          :observaciones,
          :fechacreacion_localizada,
          :habilitado,
        ]
      end

      def atributos_form
        Msip::Municipio.conf_presenta_nombre_con_origen = true
        atributos_transf_habilitado - [:id, "id", :pais, "pais"]
      end

      def genclase
        "M"; # Centro poblado
      end

      def clase_params
        params.require(:clase).permit(*atributos_form)
      end
    end
  end
end
