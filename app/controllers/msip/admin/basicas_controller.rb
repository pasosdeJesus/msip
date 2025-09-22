# frozen_string_literal: true

module Msip
  module Admin
    # Controlador de tablas básicas.
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
          r << "fechadeshabilitacion"
        end
        r
      end

      # Campos por mostrar en presentación de un registro
      def atributos_show
        atributos_transf_habilitado - [
          :fechacreacion,
          "fechacreacion",
          :fechacreacion_localizada,
          "fechacreacion_localizada",
          :fechadeshabilitacion,
          "fechadeshabilitacion",
          :fechadeshabilitacion_localizada,
          "fechadeshabilitacion_localizada",
        ] + [
          :fechacreacion_localizada,
          :fechadeshabilitacion_localizada,
        ]
      end

      # Campos que se presentar en formulario
      def atributos_form
        l = atributos_transf_habilitado - [
          "id",
          :id,
          "fechacreacion",
          :fechacreacion_localizada,
          "fechacreacion_localizada",
          "fechadeshabilitacion",
          :fechadeshabilitacion_localizada,
          "fechadeshabilitacion_localizada",
        ] | [
          :fechacreacion,
          :fechadeshabilitacion,
        ]
        l
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
