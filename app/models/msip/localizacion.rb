# frozen_string_literal: true

# Agrega metodos de clase para facilitar detalles de
# localización no suficientemente cubiertos en Rails:
# - Formato de fecha (concordante con Datepicker)
#
# Uso:
# Declare el formato por usar en config/application.rb
#   config.x.formato_fecha
# Con uno de los siguientes valores
# dd-M-yyyy, dd/M/yyyy, dd-mm-yyyy, dd/mm/yyyy y yyyy-mm-ddd
#
# En la base de datos se esperan campos de fecha en notación estándar
# de PostgreSQL anio-mes-dia, digamos fechainicio en una tabla.
#
# En su modelo agregue:
#   campofecha_localizada :fechainicio
# Y a lo largo de la aplicación utilice los nuevos metodos
# fechacreacion_localizada y fechacreacion_localizada=
# de su modelo que leen y escriben en ue usan el formato de fechas definido en config.x.formato_fecha
module Msip
  module Localizacion
    extend ActiveSupport::Concern

    include Msip::FormatoFechaHelper

    included do
    end

    class_methods do
      # La localización esta en config.x.formato_fecha que usa
      # formato de DatePicker
      def campofecha_localizado(*fields)
        fields.each do |f|
          define_method("#{f}_localizada") do
            val = self.send(f)
            fecha_estandar_local(val.to_s)
          end # define_method

          define_method("#{f}_localizada=") do |e|
            r = fecha_local_estandar(e.to_s)
            self[f] = r
          end # define_method
        end # fields.each
      end # def

      def campofecha_mesanio(*fields)
        fields.each do |f|
          define_method("#{f}_anio") do
            val = self[f]
            val&.year ? val.year : nil
          end # define_method

          define_method("#{f}_anio=") do |a|
            val = self[f]
            mes = val&.month && val.month.to_i > 0 && val.month.to_i <= 12 ? val.month.to_i : 6
            anio = a && a.to_i > 0 ? a.to_i : Date.today.year
            self[f] = Date.new(anio, mes, 15)
          end # define_method

          define_method("#{f}_mes") do
            val = self[f]
            val&.month ? val.month : nil
          end # define_method

          define_method("#{f}_mes=") do |m|
            val = self[f]
            mes = m && m.to_i > 0 && m.to_i <= 12 ? m.to_i : 6
            anio = if val&.year && val.year.to_i > 0
              val.year.to_i
            else
              Date.today.year
            end
            self[f] = Date.new(anio, mes, 15)
          end # define_method

          define_method("#{f}_mesaniolocalizado") do
            val = self[f]
            if val&.year && val.month
              val.year.to_s + "-" + val.month.to_s
            else
              ""
            end
          end # define_method
        end
      end
    end # class_methdos
  end # module Localizacion
end # module Msip
