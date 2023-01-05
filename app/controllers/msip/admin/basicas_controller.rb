# frozen_string_literal: true

module Msip
  module Admin
    class BasicasController < Msip::ModelosController
      include BasicasHelpers
      helper BasicasHelpers

      # Nombre de la tabla básica
      def clase
        "Msip::BasicaCambiar"
      end

      # Nombre del campo con nombre que identifica cada registro
      def camponombre
        :nombre
      end

      # Campos de la tabla
      def atributos_index
        [
          "id",
          "nombre",
          "observaciones",
          "fechacreacion_localizada",
          "habilitado",
        ]
      end

      def atributos_transf_habilitado
        r = atributos_index - ["habilitado", :habilitado]
        if r.exclude?("fechadeshabilitacion_localizada") &&
            r.exclude?(:fechadeshabilitacion_localizada) &&
            r.exclude?(:fechadeshabilitacion) &&
            r.exclude?("fechadeshabilitacion")
          r << "fechadeshabilitacion_localizada"
        end
        r
      end

      # Campos por mostrar en presentación de un registro
      def atributos_show
        atributos_transf_habilitado
      end

      # Campos que se presentar en formulario
      def atributos_form
        atributos_transf_habilitado - ["id", :id]
      end

      def index_reordenar(c)
        c.reorder([:nombre])
      end

      helper_method :clase,
        :atributos_index,
        :atributos_form,
        :genclase,
        :camponombre
    end
  end
end
