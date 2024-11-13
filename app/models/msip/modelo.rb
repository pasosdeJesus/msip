# frozen_string_literal: true

module Msip
  module Modelo
    extend ActiveSupport::Concern
    include Msip::Localizacion

    # En principio un modelo tiene una id

    included do
      # Si atr corresponde a tabla combinada (con relación has_many) o a
      # tabla con accepts_nested_attributes_for la retorna.
      # En otro caso retorna nil
      def self.asociacion_combinada(atr)
        r = nil
        if atr.is_a?(Hash) &&
            (atr.first[0].to_s.ends_with?("_ids") ||
             atr.first[0].to_s.ends_with?("_attributes"))
          na = atr.first[0].to_s.chomp("_ids")
          na = na.chomp("_attributes")
          a = reflect_on_all_associations
          r = a.select { |ua| ua.name.to_s == na }[0]
          if r.nil?
            msg = "Aunque #{atr} es como nombre de asociación combinada, " \
              "no se encontró #{na} entre las de #{self}"
            Rails.logger.debug(msg)
            raise msg
          end
        else
          na = atr.to_s.chomp("_ids")
          na = na.chomp("_attributes")
          a = reflect_on_all_associations
          p = a.select do |ua|
            ua.name.to_s == na &&
              (ua.macro == :has_many ||
               ua.macro == :has_and_belongs_to_many)
          end
          if p.count > 0
            r = p[0]
          end
        end
        r
      end

      # Si atr es llave foranea retorna asociación a este modelo
      # en otro caso retorna nil
      def self.asociacion_llave_foranea(atr)
        return Msip::ModeloHelper.llave_foranea_en_modelo(atr, self)
      end

      # Si atr es atributo que es llave foranea retorna su clase
      # si no retorna nil
      def self.clase_llave_foranea(atr)
        r = asociacion_llave_foranea(atr)
        if r
          return r.class_name.constantize
        end

        nil
      end

      attr_accessor :creado_en

      def creado_en
        created_at
      end

      attr_accessor :actualizado_en

      def actualizado_en
        updated_at
      end

      # Como presentar un registro por ejemplo en un campo de selección
      # Si se sobrecarga, sobrecargar también orden_presenta_nombre
      def presenta_nombre
        if respond_to?(:nombre)
          self[:nombre]
        else
          self[:id]
        end
      end

      # Columnas por las cuales ordenar en campos de selección
      # para que resulten ordenados según presenta_nombre
      # Debe coincidir con presenta_nombre
      def self.orden_presenta_nombre
        if columns&.map(&:name)&.include?("nombre")
          ["lower(nombre)"]
        else
          [:id]
        end
      end

      # Presentar campo atr del registro en index y show genérico (no sobrec)
      def presenta_gen_msip(atr)
        clf = self.class.clase_llave_foranea(atr)
        if self.class.columns_hash && self.class.columns_hash[atr.to_s] &&
            self.class.columns_hash[atr.to_s].type == :boolean
          if self[atr.to_s]
            "Si"
          else
            (self[atr.to_s].nil? ? "" : "No")
          end
        elsif self.class.asociacion_combinada(atr)
          ac = self.class.asociacion_combinada(atr).name.to_s
          e = send(ac)
          if e
            e.inject("") do |memo, i|
              (memo == "" ? "" : memo + "; ") + i.presenta_nombre.to_s
            end
          else
            ""
          end
        elsif clf
          if self[atr.to_s]
            r = clf.find(self[atr.to_s])
            if r.respond_to?(:presenta_nombre)
              r.presenta_nombre
            else
              r.id.to_s
            end
          elsif respond_to?(atr)
            r = send(atr)
            if r
              r.presenta_nombre
            else
              ""
            end
          else
            ""
          end
        elsif respond_to?(atr.to_s) &&
            send(atr.to_s).respond_to?(:presenta_nombre)
          send(atr.to_s).presenta_nombre
        elsif respond_to?(atr.to_s) && self[atr.to_s].nil?
          if send(atr.to_s).to_s.include?("ActiveRecord_Associations_CollectionProxy")
            e = send(atr.to_s)
            e.inject("") do |memo, i|
              (memo == "" ? "" : memo + "; ") +
                (i.respond_to?("presenta_nombre") ? i.presenta_nombre.to_s : i.to_s)
            end
          else
            r = send(atr.to_s)
            if !r.is_a?(Numeric) && !r.is_a?(String)
              r = r.to_s
            end
            r
          end
        elsif atr == "fechacreacion"
          created_at
        elsif atr == "fechacreacion_localizada"
          Msip::FormatoFechaHelper.fecha_estandar_local(created_at)
        elsif atr == "fechaactualizacion"
          updated_at
        elsif atr == "fechaactualizacion_localizada"
          Msip::FormatoFechaHelper.fecha_estandar_local(updated_at)
        else
          self[atr.to_s].to_s
        end
      end

      def presenta_gen(atr)
        presenta_gen_msip(atr)
      end

      # Presentar campo atr del registro en index y show para sobrecargar
      def presenta(atr)
        presenta_gen(atr)
      end

      def importa_gen(datosent, datossal, menserror, opciones = {})
        datosent.keys.each do |ll|
          case ll.to_sym
          when :actualizado_en
            self.updated_at = datosent[ll.to_sym]
          when :creado_en
            self.created_at = datosent[ll.to_sym]
          else
            asig = ll.to_s + "="
            if respond_to?(asig)
              rll = send(ll.to_s)
              if rll&.class &&
                  rll.class.ancestors.include?(Msip::Modelo)
                consr = rll.class.all.where("LOWER(UNACCENT(nombre))=LOWER(UNACCENT(?))", datosent[ll.to_sym])
                if consr.count > 0
                  n = consr.take
                  send(asig, n)
                else
                  menserror << " Se buscó sin exito en tabla basica #{rll.class} el valor '#{datosent[ll.to_sym]}'."
                end
              else
                begin
                  send(asig, datosent[ll.to_sym])
                rescue
                  menserror << " No se pudo asignar a #{ll} el valor '#{datosent[ll.to_sym]}'."
                end
              end
            else
              menserror << " No se conoce como importar atributo " \
                "'#{ll}' con valor '#{datosent[ll.to_sym]}' " \
                "en controlador '#{self.class}'."
              return nil
            end
          end
        end
        self
      end

      # En el modelo actual crea/busca registro y lo actualiza con la
      # información de datosent.
      # @param datosent diccionario con datos de entrada (modificables)
      # @param datossal Diccionario con otros datos de salida
      # @param menserror Colchon cadena con mensajes de error
      # @param opciones Opciones para la importación
      # @return Si lo logra retorna self si no lo logra retorna nil
      #   y agrega razones del error en el colchon menserror.
      def importa(datosent, datossal, menserror, opciones = {})
        importa_gen(datosent, datossal, menserror, opciones)
      end

      # Complementa importación una vez el modelo actual ha sido salvado
      # @param ulteditor_id id del usuario que importa
      # @param datossal Otros datos de salida de la importación que esta
      #   función debe salvar
      # @param menserror colchon cadena con mensajes de error
      # @param opciones Para importación
      # @return Verdadero si logra salvar todo datossal, de lo contrario
      #   salva lo que más puede y retorna falso
      def complementa_importa(ulteditor_id, datossal, menserror, opciones)
        true
      end


      # Procedimiento genérico de copiar y guardar asociaciones
      # del registro actual en el que tiene identificacióno foranea_id
      #
      # @param [Integer] foranea_id id de nuevo registro en el 
      #   cual se copian asociaciones
      # @raise RuntimeError en caso de no poder completar la copia
      def copiar_asociaciones(foranea_id, excepciones)
        self.class.reflect_on_all_associations.each do |ua|
          if ((ua.macro == :has_many && !ua.options[:through]) || 
              ua.macro == :has_and_belongs_to_many ) &&
             !excepciones.include?(ua.name)
            if ua.macro == :has_and_belongs_to_many
              cn = ua.join_table.classify
              if cn.starts_with?("Cor1440Gen")
                cn.sub!("Cor1440Gen", "Cor1440Gen::")
              end
            else
              cn = ua.class_name
            end
            cn.constantize.where(ua.foreign_key => self.id).each do |tr|
              ntr = tr.dup
              ntr[ua.foreign_key] = foranea_id
              unless ntr.save
                raise "No pudo guardar copia de #{tr.to_s}"
              end
            end # each
          end # if
        end # each
      end # def


      def excepciones_al_copiar_asociacoines
        []
      end

      # Procedimientos específicos para sacar copia de modelo
      # 
      # @param registro Copia ya guardada del registro principal que se copia
      # @raise RuntimeError si no logra completar
      def copiar_especifico(registro)
      end

      # Crea una copia de este registro y de sus asociaciones con 
      # algunas excepciones.
      #
      # @raise RuntimeError Si no logra completar la copia
      def copiar_y_guardar
        # Copiamos lo mínimo y lo cambiamos para poder guardar
        registro = self.dup
        registro.nombre += " " + Time.now.to_s
        unless registro.save(validate: false) 
          raise "No pudo duplicar registro"
        end

        copiar_asociaciones(registro.id, excepciones_al_copiar_asociaciones)

        copiar_especifico(registro)

        return registro
      end #copiar_y_guardar

      # Por omisión es posible filtrar por id
      scope :filtro_id, lambda { |id|
        # Puede ser una lista de ids separadas por ,
        if id.include?(",")
          where(id: id.split(","))
        else
          where(id: id)
        end
      }
    end # included
  end
end
