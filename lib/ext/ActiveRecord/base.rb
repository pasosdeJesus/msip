# frozen_string_literal: true

module ActiveRecord
  class Base
    class << self
      # Define métodos para manejar campos flotantes localizados.
      # @param fields [Array<Symbol>] Nombres de los campos flotantes.
      def flotante_localizado(*fields)
        fields.each do |f|
          define_method("#{f}_localizado") do
            val = if attribute_method?(f)
              read_attribute(f)
            else
              send(f) # read_attribute(f)
            end
            val&.to_s&.a_decimal_localizado
          end
          define_method("#{f}_localizado=") do |e|
            if attribute_method?(f)
              write_attribute(f, e.to_s.a_decimal_nolocalizado)
            else
              send(f.to_s + "=", e.to_s.a_decimal_nolocalizado)
            end
          end
        end
      end

      # Define métodos para manejar campos de fecha en formato dd/M/yyyy.
      # @param fields [Array<Symbol>] Nombres de los campos de fecha.
      def fecha_ddMyyyy(*fields)
        fields.each do |f|
          define_method("#{f}_ddMyyyy") do
            val = read_attribute(f)
            unless val
              return
            end

            val = val.to_s
            a = val[0, 4]
            m = val[5, 2]
            d = val[8, 2]
            meses = [
              "Ene",
              "Feb",
              "Mar",
              "Abr",
              "May",
              "Jun",
              "Jul",
              "Ago",
              "Sep",
              "Oct",
              "Nov",
              "Dic",
            ]
            "#{d}/#{meses[m.to_i - 1]}/#{a}"
          end
          define_method("#{f}_ddMyyyy=") do |e|
            val = e.to_s
            a = val[7, 4]
            nomm = val[3, 3]
            d = val[0, 2]
            meses = [
              "Ene",
              "Feb",
              "Mar",
              "Abr",
              "May",
              "Jun",
              "Jul",
              "Ago",
              "Sep",
              "Oct",
              "Nov",
              "Dic",
            ]
            m = 1
            nm = meses.index(nomm)
            if nm
              m = 1 + meses.index(nomm)
            end
            write_attribute(f, "#{a}-#{m}-#{d}")
          end
        end
      end
    end # << self
  end
end
