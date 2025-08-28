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
      send(
        :belongs_to,
        prefijo.to_s.to_sym,
        class_name: "Msip::Ubicacionpre",
        foreign_key: "#{prefijo}ubicacionpre_id",
        optional: true,
      )

      # No usamos attr_reader en los siguientes porque aunque
      # no definamos escritores para los siguientes atributos,
      # parece que rails prefiere que estén declarados o al
      # ejecutar update da:
      # unknown attribute 'ubicacionpre_centropoblado_id' for Cor1440Gen::Actividad.
      send(:attr_accessor, "#{prefijo}_pais_id")
      send(:attr_accessor, "#{prefijo}_departamento_id")
      send(:attr_accessor, "#{prefijo}_municipio_id")
      send(:attr_accessor, "#{prefijo}_centropoblado_id")
      send(:attr_accessor, "#{prefijo}_vereda_id")
      send(:attr_accessor, "#{prefijo}_lugar")
      send(:attr_accessor, "#{prefijo}_sitio")
      send(:attr_accessor, "#{prefijo}_tsitio_id")
      send(:attr_accessor, "#{prefijo}_latitud")
      send(:attr_accessor, "#{prefijo}_longitud")

      # Se espera que la clase que lo extienda también tendrá
      # flotante_localizado :ubicacionpre_latitud
      # flotante_localizado :ubicacionpre_longitud

      define_method("#{prefijo}_pais_id") do
        if send(prefijo.to_s)
          send(prefijo.to_s).pais_id
        else
          ""
        end
      end

      send(
        :belongs_to,
        "#{prefijo}_pais".to_sym,
        class_name: "Msip::Pais",
        foreign_key: "#{prefijo}_pais_id",
        optional: true,
      )

      define_method("#{prefijo}_pais") do
        send(prefijo.to_s)&.pais
      end

      define_method("#{prefijo}_departamento_id") do
        if send(prefijo.to_s)
          send(prefijo.to_s).departamento_id
        else
          ""
        end
      end

      define_method("#{prefijo}_departamento") do
        send(prefijo.to_s)&.departamento
      end

      send(
        :belongs_to,
        "#{prefijo}_departamento".to_sym,
        class_name: "Msip::Departamento",
        foreign_key: "#{prefijo}_departamento_id",
        optional: true,
      )

      define_method("#{prefijo}_municipio_id") do
        if send(prefijo.to_s)
          send(prefijo.to_s).municipio_id
        else
          ""
        end
      end

      define_method("#{prefijo}_municipio") do
        send(prefijo.to_s)&.municipio
      end

      send(
        :belongs_to,
        "#{prefijo}_municipio".to_sym,
        class_name: "Msip::Municipio",
        foreign_key: "#{prefijo}_municipio_id",
        optional: true,
      )

      define_method("#{prefijo}_centropoblado_id") do
        if send(prefijo.to_s)
          send(prefijo.to_s).centropoblado_id
        else
          ""
        end
      end

      define_method("#{prefijo}_centropoblado") do
        send(prefijo.to_s)&.centropoblado
      end

      send(
        :belongs_to,
        "#{prefijo}_centropoblado".to_sym,
        class_name: "Msip::Centropoblado",
        foreign_key: "#{prefijo}_centropoblado_id",
        optional: true,
      )

      define_method("#{prefijo}_vereda_id") do
        if send(prefijo.to_s)
          send(prefijo.to_s).vereda_id
        else
          ""
        end
      end

      define_method("#{prefijo}_vereda") do
        send(prefijo.to_s)&.vereda
      end

      send(
        :belongs_to,
        "#{prefijo}_vereda".to_sym,
        class_name: "Msip::Vereda",
        foreign_key: "#{prefijo}_vereda_id",
        optional: true,
      )


      define_method("#{prefijo}_lugar") do
        if send(prefijo.to_s)
          send(prefijo.to_s).lugar
        else
          ""
        end
      end

      define_method("#{prefijo}_sitio") do
        if send(prefijo.to_s)
          send(prefijo.to_s).sitio
        else
          ""
        end
      end

      define_method("#{prefijo}_tsitio_id") do
        if send(prefijo.to_s)
          send(prefijo.to_s).tsitio_id
        else
          ""
        end
      end

      define_method("#{prefijo}_tsitio") do
        send(prefijo.to_s)&.tsitio
      end

      send(
        :belongs_to,
        "#{prefijo}_tsitio".to_sym,
        class_name: "Msip::Tsitio",
        foreign_key: "#{prefijo}_tsitio_id",
        optional: true,
      )

      define_method("#{prefijo}_latitud") do
        if send(prefijo.to_s)
          send(prefijo.to_s).latitud
        else
          ""
        end
      end

      define_method("#{prefijo}_longitud") do
        if send(prefijo.to_s)
          send(prefijo.to_s).longitud
        else
          ""
        end
      end
    end
  end
end
