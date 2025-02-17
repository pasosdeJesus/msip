# frozen_string_literal: true

module Msip
  module ModeloHelper
    include ActionView::Helpers::TextHelper

    MESES = [
      ["ENERO", 1],
      ["FEBRERO", 2],
      ["MARZO", 3],
      ["ABRIL", 4],
      ["MAYO", 5],
      ["JUNIO", 6],
      ["JULIO", 7],
      ["AGOSTO", 8],
      ["SEPTIEMBRE", 9],
      ["OCTUBRE", 10],
      ["NOVIEMBRE", 11],
      ["DICIEMBRE", 12],
    ]

    NOSI = [
      [:NO, :N],
      [:SI, :S],
      ["SIN INFORMACIÓN", :I],
    ]

    # Retorna nombre de tabla a partir de objeto
    def nombreobj(o, plural = false)
      r = if defined? o.name
        o.name.demodulize.underscore
      else
        o.class.name.demodulize.underscore
      end
      if r == "relation"
        r = o.name.demodulize.underscore
      end
      r = plural ? r.pluralize : r
      r
    end

    # Busca ruta n sin parámetros en la aplicación, luego en main_app
    # y luego en motores
    # Debió implementarse porque respond_to? no está operando bien para rutas
    # ni con rails 6.0 ni con rails 6.1
    # @return [] sii no se encuentra ruta n o
    #   [rutacompleta, resultado] si se encuentra, donde rutacompleta es ruta
    #   con posible prefijo (main_app o un motor) y resultado es el resultado
    #   de la llamada
    def ruta_responde_0p(n)
      begin
        r = send(n)
        return [n, r]
      rescue NoMethodError
        begin
          r = main_app.send(n)
          return ["main_app.#{n}", r]
        rescue NoMethodError
          Rails.application.routes.routes.custom_routes.map(&:name).each do |cr|
            next unless cr

            begin
              r = send(cr).send(n)
              return [cr + "." + n, r]
            rescue NoMethodError => e
              Rails.logger.debug { "NoMethodError e=#{e}" }
            end
          end
        end
      end
      []
    end

    # Busca ruta n con un parámetro p en la aplicación, luego en main_app
    # y luego en motores
    # Debió implementarse porque respond_to? no está operando bien para rutas
    # con rails 6.0 ni con rails 6.1
    # return [] sii no se encuentra ruta n o
    #   [rutacompleta, resultado] si se encuentra, donde rutacompleta es ruta
    #   con posible prefijo (main_app o un motor) y resultado es el resultado
    #   de la llamada
    def ruta_responde_1p(n, p)
      begin
        r = send(n, p)
        return [n, r]
      rescue NoMethodError
        begin
          r = main_app.send(n, p)
          return ["main_app.#{n}", r]
        rescue NoMethodError
          Rails.application.routes.routes.custom_routes.map(&:name).each do |cr|
            next unless cr

            begin
              r = send(cr).send(n, p)
              return [cr + "." + n, r]
            rescue NoMethodError
            end
          end
        end
      end
      []
    end

    # Ruta para listado de registros o
    # @param posfijo_path [Boolean] Si el posfijo de la ruta es _path
    #   (si es falso se usa _url)
    def modelos_path(o, posfijo_path = true)
      if o.nil?
        return "#"
      end

      n = if o.respond_to?(:modelos_path)
        o.modelos_path
      elsif o.respond_to?(:klass) && o.klass.respond_to?(:modelos_path)
        o.klass.modelos_path
      else
        nombreobj(o, true) + "_path"
      end
      unless posfijo_path
        n = n.chomp("_path") + "_url"
      end

      arr = ruta_responde_0p(n)
      if arr != []
        return arr[1]
      end

      arr = ruta_responde_0p("admin_#{n}")
      if arr != []
        return arr[1]
      end

      raise "No se encontró ruta a lista de #{n}"
    end

    # Url para listado de registros o
    def modelos_url(o)
      modelos_path(o, false)
    end

    # Ruta a resumen de un registro
    # En caso de registros no existentes retorna ruta para crearlo con POST
    def modelo_path(o, posfijo_path = true)
      if o.nil?
        return main_app.root_path
      end

      if o.id
        n = nombreobj(o, false) + "_path"
      else
        n = "crea_" + nombreobj(o, true) + "_path"
        unless respond_to?(n)
          n = "crea_" + nombreobj(o, false) + "_path"
          unless respond_to?(n)
            n = nombreobj(o, true) + "_path"
          end
        end
      end

      unless posfijo_path
        n = n.chomp("_path") + "_url"
      end

      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      arr = ruta_responde_1p("admin_#{n}", o)
      if arr != []
        return arr[1]
      end

      raise "No se encontró ruta para examinar un #{n}"
    end

    # URL para ver resumen de un registro
    def modelo_url(o, format)
      modelo_path(o, false)
    end

    # Ruta para crear un nuevo registro o
    def new_modelo_path(o)
      n = "new_#{nombreobj(o)}_path"
      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      n = "new_admin_#{nombreobj(o)}_path"
      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      raise "No se encontró ruta para nuevo #{n}"
    end

    # Ruta para editar un registro existente o
    def edit_modelo_path(o)
      n = "edit_#{nombreobj(o)}_path"
      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      n = "edit_admin_#{nombreobj(o)}_path"
      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      raise "No se encontro ruta para editar #{n}"
    end

    # Ruta para copiar un registro
    def copiar_modelo_path(o)
      n = "copiar_#{nombreobj(o)}_path"
      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      n = "copiar_admin_#{nombreobj(o)}_path"
      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      n = "admin_copiar_#{nombreobj(o)}_path"
      arr = ruta_responde_1p(n, o)
      if arr != []
        return arr[1]
      end

      raise "No se encontro ruta para copiar #{n}"
    end

    def self.poromision(params, s, valorsp = "")
      if params.nil? || params[:filtro].nil? || params[:filtro][s].nil?
        valorsp
      elsif params[:filtro][s].is_a?(Array)
        params[:filtro][s].map { |c| Msip::Usuario.connection.quote_string(c) }
      else
        Msip::Usuario.connection.quote_string(params[:filtro][s])
      end
    end

    def self.poromision_sf(params, s, valorsp = "")
      if params.nil? || params[s].nil?
        valorsp
      else
        Msip::Usuario.connection.quote_string(params[s])
      end
    end

    def poromision_con2p(params, p1, p2, s,
      valorsp = "")
      if !params || !params[p1] || !params[p1][p2] ||
          !params[p1][p2][s]
        valorsp
      else
        Msip::Usuario.connection.quote_string(params[p1][p2][s])
      end
    end
    module_function :poromision_con2p

    # Convierte un atributo a nombre de filtro (dejando solo letras numeros y _)
    def self.nom_filtro(atr)
      atr.to_s.gsub(/[^a-z_A-Z0-9]/, "")
    end

    # Nombre y apellido de una persona
    def self.nomap_persona(p)
      if p
        r = p.nombres + " " + p.apellidos
        return r.strip
      end
      ""
    end

    # Retorna etiqueta que corresponde a una identificación
    # en una colección al estilo
    # [['EN EJECUCIÓN', :J],
    #  ['EN TRAMITE', :E],
    #  ['RECHAZADO', :R],
    #  ['TERMINADO', :T]]
    def self.etiqueta_coleccion(a, l)
      return "" if l.nil? || (l == "")

      res = a.select do |r|
        r[1].to_s == l.to_s
      end
      if res.empty?
        return "ERROR-CON-#{a}-Y-#{l}-FAVOR-REPORTAR"
      end

      res[0][0]
    end

    # De requerirse aumenta la colección de habilitadoas con la última
    # elegida (que ya podría estar deshabilitada pero debe mantenerse
    # con propósitos históricos).
    def self.coleccion_basica(basica, ultimos_ids = nil)
      h = basica.habilitados
      unless ultimos_ids.nil?
        idsh = h.map(&:id)
        lu = ultimos_ids
        if ultimos_ids.is_a?(Integer)
          lu = [ultimos_ids]
        end
        lu.each do |uid|
          unless idsh.include?(uid)
            idsh << uid
          end
        end
        h = basica.where(id: idsh)
      end
      h
    end

    def lista_tablas_basicas(current_ability, ntablas = {})
      ab = current_ability
      ab.tablasbasicas.each do |t|
        k = Ability.tb_clase(t)
        next unless current_ability.can?(:new, k)

        n = k.human_attribute_name(t[1].pluralize.capitalize)
        r = "admin/#{t[1].pluralize}"
        ntablas[n] = r
      end
      ntablasor = ntablas.keys.localize(:es).sort.to_a
      ntablasor
    end
    module_function :lista_tablas_basicas

    # Retorna opciones habilitadas de una tabla básica
    # mas la ya elegidas en un campo de un formulario
    def opciones_tabla_basica(clase, f, campo)
      col1 = clase.all
      if col1.respond_to?(:habilitados)
        col1 = col1.habilitados
      end
      if col1.respond_to?(:filtro_permanente)
        col1 = col1.filtro_permanente
      end
      ids1 = col1.pluck(:id)
      ids2 = []
      if f.object.respond_to?(campo) && !f.object.send(campo).nil?
        r = f.object.send(campo)
        if r.is_a?(Array)
          ids2 = f.object.send(campo).select { |v| v != "" }.map(&:to_i)
        elsif r.nil? || r == ""
          ids2 = []
        elsif f.object.respond_to?("#{campo}_ids")
          ids2 = f.object.send("#{campo}_ids")
          if ids2.nil?
            ids2 = [f.object.send(campo.to_s)]
          end
        elsif r.respond_to?(:id)
          ids2 = [r.id]
        elsif r.respond_to?(:to_i)
          ids2 = [r.to_i]
        else
          ids2 = []
        end
      end
      res = clase.where(id: ids1 | ids2)
      if clase.has_attribute?(:nombre)
        res = res.order(:nombre)
      end
      res
    end
    module_function :opciones_tabla_basica

    # Si atr es llave foranea en modelo m retorna asociación a
    # ese modelo en otro caso retorna nil
    def llave_foranea_en_modelo(atr, m)
      aso = m.reflect_on_all_associations
      bel = aso.select { |a| a.macro == :belongs_to }
      fk = bel.map do |e|
        e.foreign_key.to_s
      end
      if fk.include?(atr.to_s)
        r = aso.select do |a|
          (a.is_a?(ActiveRecord::Reflection::HasManyReflection) ||
           a.is_a?(ActiveRecord::Reflection::BelongsToReflection)) &&
            a.foreign_key.to_s == atr.to_s
        end[0]
        return r
      end
      ln = bel.map do |e|
        e.name.to_s
      end
      if ln.include?(atr.to_s)
        r = aso.select do |a|
          (a.is_a?(ActiveRecord::Reflection::HasManyReflection) ||
           a.is_a?(ActiveRecord::Reflection::BelongsToReflection)) &&
            a.name.to_s == atr.to_s
        end[0]
        return r
      end

      nil
    end
    module_function :llave_foranea_en_modelo
  end
end
