# frozen_string_literal: true

module Msip
  module Basica
    extend ActiveSupport::Concern

    included do
      include Msip::Localizacion
      include Msip::Modelo

      # Scope para registros habilitados.
      # @param campoord [String] Campo por el cual ordenar.
      # @return [ActiveRecord::Relation] Registros habilitados ordenados.
      scope :habilitados, ->(campoord = "nombre") {
        where(fechadeshabilitacion: nil).order(campoord.to_sym)
      }

      # Scope para filtro permanente (sin efecto por ahora).
      scope :filtro_permanente, -> () {
      }

      campofecha_localizado :fechacreacion
      campofecha_localizado :fechadeshabilitacion
      validates :nombre,
        presence: true,
        allow_blank: false,
        length: { maximum: 500 }
      validates :observaciones, length: { maximum: 5000 }
      validates :fechacreacion, presence: true, allow_blank: false

      # Las tablas basicas que tengan repetido deben definir la constante
      # Nombresunicos=false
      # Ver por ejemplo departamento
      validates :nombre, uniqueness: {
        case_sensitive: false,
        if: proc { |rb|
              !(defined? rb.class::Nombresunicos) || rb.class::Nombresunicos
            },
      }

      # Valida que la fecha de creación sea posterior al año 2000.
      # @return [void]
      validate :fechacreacion_posible?
      def fechacreacion_posible?
        if !fechacreacion || fechacreacion < Date.new(2000, 1, 1)
          errors.add(:fechacreacion, "Debe ser reciente (posterior a 2000)")
        end
      end

      # Valida que la fecha de deshabilitación sea posterior a la de creación.
      # @return [void]
      validate :fechadeshabilitacion_posible?
      def fechadeshabilitacion_posible?
        if fechadeshabilitacion.present? && fechadeshabilitacion < fechacreacion
          errors.add(:fechadeshabilitacion, "Debe ser posterior a la de creación")
        end
      end

      # Por defecto tablas básicas con datos en mayúsculas y sin espacios redundantes
      # Para cambiarlo en una tabla básica definir por ejemplo:
      # def nombre=(val)
      #   self[:nombre] = val.squish
      # end
      # Convierte el nombre a mayúsculas y elimina espacios redundantes.
      # @param val [String] El valor a asignar al nombre.
      # @return [void]
      def nombre=(val)
        self[:nombre] = val.upcase.squish if val
      end

      # Si atr corresponde a tabla combinada la retorna
      # en otro caso retorna nil
      # Retorna la asociación combinada si `atr` corresponde a una tabla combinada.
      # @param atr [Object] Atributo a verificar.
      # @return [ActiveRecord::Associations::Association, nil] La asociación combinada o nil.
      def asociacion_combinada(atr)
        if atr.is_a?(Hash) && atr.first[0].to_s.ends_with?("_ids")
          na = atr.first[0].to_s.chomp("_ids")
          a = self.class.reflect_on_all_associations
          r = a.select { |ua| ua.name.to_s == na }[0]
          return r
        end
        nil
      end

      # Si atr es llave foranea retorna asociación a este modelo
      # en otro caso retorna nil
      # Retorna la asociación si `atr` es una llave foránea.
      # @param atr [String] Atributo a verificar.
      # @return [ActiveRecord::Associations::Association, nil] La asociación o nil.
      def asociacion_llave_foranea(atr)
        aso = self.class.reflect_on_all_associations
        bel = aso.select { |a| a.macro == :belongs_to }
        fk = bel.map(&:foreign_key)
        if fk.include?(atr)
          r = aso.select { |a| a.foreign_key == atr }[0]
          return r
        end
        nil
      end

      # Si atr es atributo que es llave foranea retorna su clase
      # si no retorna nil
      # Retorna la clase de la llave foránea si `atr` es un atributo que es llave foránea.
      # @param atr [String] Atributo a verificar.
      # @return [Class, nil] La clase de la llave foránea o nil.
      def clase_llave_foranea(atr)
        r = asociacion_llave_foranea(atr)
        if r
          return r.class_name.constantize
        end

        nil
      end

      # Presentar nombre del registro en index y show
      # Presenta el nombre del registro en index y show.
      # @return [String] El nombre del registro.
      def presenta_nombre
        self["nombre"]
      end

      # Presentar campo atr del registro en index y show genérico (no sobrec)
      #      def presenta_gen(atr)
      #        clf = clase_llave_foranea(atr)
      #        if self.class.columns_hash && self.class.columns_hash[atr] &&
      #          self.class.columns_hash[atr].type == :boolean
      #          self[atr] ? "Si" : "No"
      #        elsif asociacion_combinada(atr)
      #          ac = asociacion_combinada(atr).name.to_s
      #          e = self.send(ac)
      #          e.inject("") { |memo, i|
      #            (memo == "" ? "" : memo + "; ") + i.presenta_nombre
      #          }
      #        elsif clf
      #          if (self[atr.to_s])
      #            clf.find(self[atr.to_s]).presenta_nombre
      #          else
      #            ""
      #          end
      #        elsif self.respond_to?(atr) && self[atr.to_s].nil?
      #          self.send(atr).to_s
      #        else
      #          self[atr.to_s].to_s
      #        end
      #      end
      #
      #      # Presentar campo atr del registro en index y show para sobrecargar
      #      def presenta(atr)
      #        presenta_gen(atr)
      #      end

      # Para búsquedas tipo autocompletacion en base de datos campos a observar
      # Para búsquedas tipo autocompletacion en base de datos, campos a observar.
      # @return [Array<String>] Lista de campos a observar.
      def self.busca_etiqueta_campos
        ["nombre"]
      end

      # Para búsquedas tipo autocompletacion etiqueta que se retorna
      # Para búsquedas tipo autocompletacion, etiqueta que se retorna.
      # @return [String] La etiqueta para autocompletacion.
      def busca_etiqueta
        v = self.class.busca_etiqueta_campos.map do |c|
          self[c]
        end
        v.join(" ")
      end

      # Para búsquedas tipo autocompletacion valor que se retorna
      # Para búsquedas tipo autocompletacion, valor que se retorna.
      # @return [Object] El valor para autocompletacion.
      def busca_valor
        self["id"]
      end

      # Atributo para indicar si el registro está habilitado.
      # @return [String] "Si" si está habilitado, "No" si no.
      attr_accessor :habilitado

      def habilitado
        fechadeshabilitacion.nil? ? "Si" : "No"
      end

      # Scope para filtrar por estado de habilitación.
      # @param o [String] "SI" para habilitados, "NO" para deshabilitados.
      # @return [ActiveRecord::Relation] Registros filtrados por estado de habilitación.
      scope :filtro_habilitado, lambda { |o|
        if o.upcase.strip == "SI"
          where("#{table_name}.fechadeshabilitacion IS NULL")
        elsif o.upcase.strip == "NO"
          where.not("#{table_name}.fechadeshabilitacion IS NULL")
          # where.not(fechadeshabilitacion: nil)
        end
      }

      # Scope para filtrar por nombre.
      # @param n [String] Nombre a buscar.
      # @return [ActiveRecord::Relation] Registros filtrados por nombre.
      scope :filtro_nombre, lambda { |n|
        where("unaccent(#{table_name}.nombre) ILIKE '%' || unaccent(?) || '%'", n)
      }

      # Scope para filtrar por observaciones.
      # @param o [String] Observaciones a buscar.
      # @return [ActiveRecord::Relation] Registros filtrados por observaciones.
      scope :filtro_observaciones, lambda { |o|
        where("unaccent(#{table_name}.observaciones) ILIKE '%' || unaccent(?) || '%'", o)
      }

      # Scope para filtrar por fecha de creación inicial.
      # @param f [Date] Fecha de creación inicial.
      # @return [ActiveRecord::Relation] Registros filtrados por fecha de creación inicial.
      scope :filtro_fechacreacionini, lambda { |f|
        where("fechacreacion >= ?", f)
        # El control de fecha HTML estándar retorna la fecha
        # en formato yyyy-mm-dd siempre
      }

      # Scope para filtrar por fecha de creación final.
      # @param f [Date] Fecha de creación final.
      # @return [ActiveRecord::Relation] Registros filtrados por fecha de creación final.
      scope :filtro_fechacreacionfin, lambda { |f|
        where("fechacreacion <= ?", f)
      }
    end
  end
end
