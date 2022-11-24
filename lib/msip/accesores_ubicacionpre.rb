# frozen_string_literal: true

# Agrega accesores del estilo prefijo_pais_id, prefijo_departamento_id... etc
# A un modelo que tiene un campo ubicacionpre de nombre prefijoubicacionpre_id
#
# Utilizar con extend
module Msip
  module AccesoresUbicacionpre
    # Como prefijo se espera salida, expulsion, destino, llegada
    # y que la tabla tenga el respectivo campo salidaubicacionpre_id,
    # expulsionubicacionpre_id, destinoubicacionpre_id o
    # llegadaubicacionpre_id.
    def accesores_ubicacionpre(prefijo)
      send(:belongs_to, "#{prefijo}".to_sym,
        class_name: "Msip::Ubicacionpre",
        foreign_key: "#{prefijo}ubicacionpre_id",
        optional: true)

      # No usamos attr_reader en los siguientes porque aunque
      # no definamos escritores para los siguientes atributos,
      # parece que rails prefiere que estén declarados o al
      # ejecutar update da:
      # unknown attribute 'ubicacionpre_clase_id' for Cor1440Gen::Actividad.
      send(:attr_accessor, "#{prefijo}_pais_id")
      send(:attr_accessor, "#{prefijo}_departamento_id")
      send(:attr_accessor, "#{prefijo}_municipio_id")
      send(:attr_accessor, "#{prefijo}_clase_id")
      send(:attr_accessor, "#{prefijo}_lugar")
      send(:attr_accessor, "#{prefijo}_sitio")
      send(:attr_accessor, "#{prefijo}_tsitio_id")
      send(:attr_accessor, "#{prefijo}_latitud")
      send(:attr_accessor, "#{prefijo}_longitud")

      # Se espera que la clase que lo extienda también tendrá
      # flotante_localizado :ubicacionpre_latitud
      # flotante_localizado :ubicacionpre_longitud

      define_method("#{prefijo}_pais_id") do
        if send("#{prefijo}")
          send("#{prefijo}").pais_id
        else
          ""
        end
      end

      send(:belongs_to, "#{prefijo}_pais".to_sym,
        class_name: "Msip::Pais",
        foreign_key: "#{prefijo}_pais_id",
        optional: true)

      define_method("#{prefijo}_pais") do
        if send("#{prefijo}")
          send("#{prefijo}").pais
        end
      end

      define_method("#{prefijo}_departamento_id") do
        if send("#{prefijo}")
          send("#{prefijo}").departamento_id
        else
          ""
        end
      end

      define_method("#{prefijo}_departamento") do
        if send("#{prefijo}")
          send("#{prefijo}").departamento
        end
      end

      send(:belongs_to, "#{prefijo}_departamento".to_sym,
        class_name: "Msip::Departamento",
        foreign_key: "#{prefijo}_departamento_id",
        optional: true)

      define_method("#{prefijo}_municipio_id") do
        if send("#{prefijo}")
          send("#{prefijo}").municipio_id
        else
          ""
        end
      end

      define_method("#{prefijo}_municipio") do
        if send("#{prefijo}")
          send("#{prefijo}").municipio
        end
      end

      send(:belongs_to, "#{prefijo}_municipio".to_sym,
        class_name: "Msip::Municipio",
        foreign_key: "#{prefijo}_municipio_id",
        optional: true)

      define_method("#{prefijo}_clase_id") do
        if send("#{prefijo}")
          send("#{prefijo}").clase_id
        else
          ""
        end
      end

      define_method("#{prefijo}_clase") do
        if send("#{prefijo}")
          send("#{prefijo}").clase
        end
      end

      send(:belongs_to, "#{prefijo}_clase".to_sym,
        class_name: "Msip::Clase",
        foreign_key: "#{prefijo}_clase_id",
        optional: true)

      define_method("#{prefijo}_lugar") do
        if send("#{prefijo}")
          send("#{prefijo}").lugar
        else
          ""
        end
      end

      define_method("#{prefijo}_sitio") do
        if send("#{prefijo}")
          send("#{prefijo}").sitio
        else
          ""
        end
      end

      define_method("#{prefijo}_tsitio_id") do
        if send("#{prefijo}")
          send("#{prefijo}").tsitio_id
        else
          ""
        end
      end

      define_method("#{prefijo}_tsitio") do
        if send("#{prefijo}")
          send("#{prefijo}").tsitio
        end
      end

      send(:belongs_to, "#{prefijo}_tsitio".to_sym,
        class_name: "Msip::Tsitio",
        foreign_key: "#{prefijo}_tsitio_id",
        optional: true)

      define_method("#{prefijo}_latitud") do
        if send("#{prefijo}")
          send("#{prefijo}").latitud
        else
          ""
        end
      end

      define_method("#{prefijo}_longitud") do
        if send("#{prefijo}")
          send("#{prefijo}").longitud
        else
          ""
        end
      end
    end
  end
end
