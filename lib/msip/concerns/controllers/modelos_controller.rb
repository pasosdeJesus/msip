# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module ModelosController
        extend ActiveSupport::Concern

        included do
          include ModeloHelper
          helper ModeloHelper

          # Deben registrarse en Msip::Bitacora usos de este controlador
          def registrar_en_bitacora
            false
          end

          # Permite especificar atributos por agregar al `<form>` generado
          # @return un diccionario de atributos por agregar, por ejemplo
          #         { 'data-controller': 'msip--sindocaut' }
          def atributos_html_encabezado_formulario
            {}
          end

          # Permite modificar params
          def prefiltrar
          end

          def nom_filtro(ai)
            Msip::ModeloHelper.nom_filtro(ai)
          end

          # Filtra por control de acceso
          def filtrar_ca(reg)
            reg
          end

          def filtrar(reg, params_filtro)
            # Control para fecha podría no estar localizado aunque
            # campos por presentar si
            latr1 = atributos_index.map do |a|
              if a.to_s.end_with?("_localizada")
                [a, a.to_s.chomp("_localizada")]
              else
                [a]
              end
            end.flatten
            latr2 = atributos_filtro_antestabla.map do |a|
              if a.to_s.end_with?("_localizada")
                [a, a.to_s.chomp("_localizada")]
              else
                [a]
              end
            end.flatten
            latr = latr1 + latr2
            quedan = params_filtro.keys
            latr.each do |ai|
              i = nom_filtro(ai)
              if params_filtro["bus#{i}"] &&
                  params_filtro["bus#{i}"] != "" &&
                  reg.respond_to?("filtro_#{i}")
                reg = reg.send("filtro_#{i}", params_filtro["bus#{i}"])
                quedan -= ["bus#{i}"]
              else
                if params_filtro["bus#{i}ini"] &&
                    params_filtro["bus#{i}ini"] != "" &&
                    reg.respond_to?("filtro_#{i}ini")
                  reg = reg.send(
                    "filtro_#{i}ini",
                    params_filtro["bus#{i}ini"],
                  )
                  quedan -= ["bus#{i}ini"]
                end
                if params_filtro["bus#{i}fin"] &&
                    params_filtro["bus#{i}fin"] != "" &&
                    reg.respond_to?("filtro_#{i}fin")
                  reg = reg.send(
                    "filtro_#{i}fin",
                    params_filtro["bus#{i}fin"],
                  )
                  quedan -= ["bus#{i}ini"]
                end
              end
            end
            # También puede filtrarse por una o más identificaciones
            # por ejemplo con un URL con parámetro filtro[ids]=3,4
            if params_filtro["ids"]
              lids1 = params_filtro["ids"].split(",")
              lids = lids1.map(&:to_i)
              if !lids.empty? && lids[0] > 0
                reg = reg.where(id: lids)
              end
              quedan -= ["ids"]
            end
            quedan2 = params_filtro.clone.delete_if do |l, v|
              v == "" || quedan.exclude?(l)
            end
            if reg.respond_to?("filtrar_alterno")
              reg = reg.filtrar_alterno(quedan2)
            end
            reg
          end

          def index_otros_formatos(format, params)
            nil
          end

          def index_reordenar(c)
            c.reorder([:id])
          end

          def index_plantillas
          end

          # Listado de registros
          def index_msip(c = nil)
            if !c.nil?
              if c.class.to_s.end_with?("ActiveRecord_Relation")
                if clase.constantize.to_s != c.klass.to_s
                  Rails.logger.debug do
                    "No concuerdan #{clase.constantize} y " \
                      "klass #{c.klass}"
                  end
                  # return
                end
              elsif clase.constantize.to_s != c.class.to_s
                Rails.logger.debug { "No concuerdan #{clase.constantize} y class #{c.class}" }
                # return
              end
            else
              c = clase.constantize
            end

            c = c.accessible_by(current_ability)
            if c.count == 0 && cannot?(:index, clase.constantize)
              # Supone alias por omision de https://github.com/CanCanCommunity/cancancan/blob/develop/lib/cancan/ability/actions.rb
              if cannot?(:read, clase.constantize)
                flash[:error] = "No se puede acceder a #{clase}"
                redirect_to(main_app.root_path)
                return
              end
              # authorize! :read, clase.constantize
            end

            # Cambiar params
            prefiltrar
            # Prefiltrar de acuerdo a control de acceso
            c = filtrar_ca(c)
            # Autocompletar
            if params && params[:term] && params[:term] != ""
              term = ActiveRecord::Base.connection.quote_string(params[:term])
              consNom = term.downcase.strip # sin_tildes
              consNom.gsub!(/ +/, ":* & ")
              unless consNom.empty?
                consNom += ":*"
              end
              #  El caso de uso tipico es autocompletación
              #  por lo que no usamos diccionario en español para evitar
              #  problemas con algoritmo de raices.
              where = " to_tsvector('simple', unaccent(" +
                c.busca_etiqueta_campos.join(" || ' ' || ") +
                ")) @@ to_tsquery('simple', ?)"
              c = c.where(where, consNom)
            end
            if params && params[:filtro]
              c = filtrar(c, params[:filtro])
            end

            c = index_reordenar(c) if c
            index_plantillas

            respond_to do |format|
              if registrar_en_bitacora
                Msip::Bitacora.a(
                  request.remote_ip,
                  current_usuario.id,
                  request.url,
                  params,
                  clase,
                  0,
                  "listar",
                  "",
                )
              end
              format.html do
                @registros = @registro = c&.paginate(
                  page: params[:pagina], per_page: 20,
                )
                render(:index, layout: "layouts/application")
                return
              end
              @registros = @registro = c&.all
              regjson = if params &&
                  ((params[:presenta_nombre] &&
                    params[:presenta_nombre] == "1") ||
                   (params[:filtro] && params[:filtro][:presenta_nombre] &&
                    params[:filtro][:presenta_nombre] == "1")) && @registros
                @registros.map do |r|
                  { id: r.id, presenta_nombre: r.presenta_nombre }
                end
              else
                @registros
              end
              format.json do
                render(:index, json: regjson)
                return
              end
              format.js do
                if params[:_msip_enviarautomatico]
                  @registros = @registro = c&.paginate(
                    page: params[:pagina], per_page: 20,
                  )
                  render(:index, layout: "layouts/application")
                else
                  render(:index, json: regjson)
                end
                return
              end
              index_otros_formatos(format, params)
            end
          end

          # Listado de registros
          def index(c = nil)
            index_msip(c)
          end

          def show_plantillas
          end

          def presentar_intermedio(registro, usuario_actual_id)
          end

          # Despliega detalle de un registro
          def show
            @registro = clase.constantize.find(params[:id])
            if @registro.respond_to?("current_usuario=")
              @registro.current_usuario = current_usuario
            end
            if cannot?(:show, @registro)
              # Supone alias por omision de https://github.com/CanCanCommunity/cancancan/blob/develop/lib/cancan/ability/actions.rb
              authorize!(:read, @registro)
            end
            c2 = clase.demodulize.underscore
            eval("@#{c2} = @registro")
            presentar_intermedio(@registro, current_usuario.id)
            show_plantillas
            if registrar_en_bitacora
              Msip::Bitacora.a(
                request.remote_ip,
                current_usuario.id,
                request.url,
                params,
                @registro.class.to_s,
                @registro.id,
                "presentar",
                "",
              )
            end
            render(layout: "application")
          end

          # Filtro al contenido de params
          # Para modificar parametros antes de que sean procesados en create y update.
          # Puede servir para sanear información (si no quieren usarse validaciones).
          def filtra_contenido_params
          end

          def nuevo_intermedio(registro)
          end

          # Presenta formulario para crear nuevo registro
          def new_gen
            if cannot?(:new, clase.constantize)
              # Supone alias por omision de https://github.com/CanCanCommunity/cancancan/blob/develop/lib/cancan/ability/actions.rb
              authorize!(:create, clase.constantize)
            end
            @registro = clase.constantize.new
            if @registro.respond_to?("current_usuario=")
              @registro.current_usuario = current_usuario
            end
            if @registro.respond_to?(:fechacreacion)
              @registro.fechacreacion = Time.zone.now.strftime("%Y-%m-%d")
            end

            nuevo_intermedio(@registro)

            if registrar_en_bitacora
              Msip::Bitacora.a(
                request.remote_ip,
                current_usuario.id,
                request.url,
                params,
                @registro.class.to_s,
                nil,
                "iniciar",
                "",
              )
            end
          end

          def new
            new_gen
            render(layout: "application")
          end

          # Llamada en mitad de un edit
          # Después de autenticar, antes de desplegar si retorna
          # false no se despliega en llamadora
          def editar_intermedio(registro, usuario_actual_id)
            true
          end

          # Despliega formulario para editar un registro
          def edit_gen
            @registro = clase.constantize.find(params[:id])
            if @registro.respond_to?("current_usuario=")
              @registro.current_usuario = current_usuario
            end
            if cannot?(:edit, clase.constantize)
              # Supone alias por omision de https://github.com/CanCanCommunity/cancancan/blob/develop/lib/cancan/ability/actions.rb
              authorize!(:update, @registro)
            end
            if editar_intermedio(@registro, current_usuario.id)
              if registrar_en_bitacora
                Msip::Bitacora.a(
                  request.remote_ip,
                  current_usuario.id,
                  request.url,
                  params,
                  @registro.class.to_s,
                  @registro.id,
                  "editar",
                  "",
                )
              end
              render(layout: "application")
            end
          end

          def edit
            edit_gen
          end

          # Validaciones adicionales a las del modelo que
          # requieren current_usuario y current_ability y que
          # bien no se desean que generen una excepción o bien
          # que no se pudieron realizar con cancancan.
          # @return true si pasan validaciones o false y deja detalle en
          # @validaciones_error
          def validaciones(registro)
            @validaciones_error = ""
            true
          end

          # Crea un registro a partir de información de formulario
          def create_gen(registro = nil)
            c2 = clase.demodulize.underscore
            if registro
              @registro = registro
            else
              filtra_contenido_params
              pf = send(c2 + "_params")
              @registro = clase.constantize.new(pf)
            end
            if @registro.respond_to?(:fechacreacion)
              @registro.fechacreacion = Time.zone.now.strftime("%Y-%m-%d")
            end
            if @registro.respond_to?("current_usuario=")
              @registro.current_usuario = current_usuario
            end
            # render requiere el siguiente segun se confirmó
            # y comentó en update_gen
            eval("@#{c2} = @registro")
            if !validaciones(@registro) || !@registro.valid?
              flash[:error] = @validaciones_error
              render(action: "new", layout: "application")
              return
            end
            authorize!(:create, @registro)
            creada = genclase == "M" ? "creado" : "creada"
            respond_to do |format|
              if @registro.save
                if registrar_en_bitacora
                  Msip::Bitacora.a(
                    request.remote_ip,
                    current_usuario.id,
                    request.url,
                    params,
                    @registro.class.to_s,
                    @registro.id,
                    "crear",
                    "",
                  )
                end
                format.html do
                  redirect_to(
                    modelo_path(@registro),
                    notice: clase + " #{creada}.",
                  )
                end
                format.json do
                  render(action: "show", status: :created, location: @registro)
                end
              else
                @registro.id = nil; # Volver a elegir Id
                format.html { render(action: "new", layout: "application") }
                format.json do
                  render(json: @registro.errors, status: :unprocessable_entity)
                end
              end
            end
          end

          def create
            authorize!(:new, clase.constantize)
            create_gen
          end

          # Retorna verdader si logra hacer operaciones adicionales
          # de actualización a @registro
          def actualizar_intermedio
            true
          end

          # Actualiza un registro con información recibida de formulario
          def update_gen(registro = nil)
            @registro = if registro
              registro
            else
              clase.constantize.find(params[:id])
            end
            if @registro.respond_to?("current_usuario=")
              @registro.current_usuario = current_usuario
            end
            if @registro.respond_to?("controlador=")
              @registro.controlador = self
            end

            authorize!(:update, @registro)
            filtra_contenido_params
            c2 = clase.demodulize.underscore
            pf = send(c2 + "_params")
            @registro.assign_attributes(pf)
            # El siguiente se necesita porque por lo visto render
            # cuando viene de actividades_controller emplea @actividad
            eval("@#{c2} = @registro")
            respond_to do |format|
              if actualizar_intermedio && validaciones(@registro) &&
                  @registro.valid? && @registro.save
                if registrar_en_bitacora
                  regcorto = clase.demodulize.underscore.to_s
                  Msip::Bitacora.agregar_actualizar(
                    request,
                    regcorto,
                    :bitacora_cambio,
                    current_usuario.id,
                    params,
                    @registro.class.to_s,
                    @registro.id,
                  )
                end

                format.html do
                  if request.method == "PATCH" && request.xhr?
                    if params[:_msip_enviarautomatico_y_repinta] ||
                        request.params[:_msip_enviarautomatico_y_repinta]
                      render(
                        action: "edit",
                        layout: "application",
                        notice: "Registro actualizado.",
                      )
                    else
                      render(
                        action: "show",
                        layout: "application",
                        notice: "Registro actualizado.",
                      )
                    end
                  elsif params[:_msip_enviarautomatico_y_repinta] ||
                      request.params[:_msip_enviarautomatico_y_repinta]
                    redirect_to(
                      edit_modelo_path(@registro),
                      turbo: false,
                    )
                  else
                    actualizada = if genclase == "M"
                      "actualizado"
                    else
                      "actualizada"
                    end
                    redirect_to(
                      modelo_path(@registro),
                      notice: clase + " #{actualizada}.",
                    )
                  end
                  return
                end

                format.json do
                  head(:no_content)
                end
              else
                format.html do
                  flash[:error] = @validaciones_error
                  render(action: "edit", layout: "application")
                end
                format.json do
                  render(
                    json: @registro.errors,
                    status: :unprocessable_entity,
                  )
                end
              end
            end
          end

          def update(registro = nil)
            update_gen(registro)
          end

          # Elimina un registro
          def destroy_gen(mens = "", verifica_tablas_union = true)
            @registro = clase.constantize.find(params[:id])
            if @registro.respond_to?("current_usuario=")
              @registro.current_usuario = current_usuario
            end

            authorize!(:destroy, @registro)
            if verifica_tablas_union && @registro.class.columns_hash
              m = @registro.class.reflect_on_all_associations(:has_many)
              m.each do |r|
                next if r.options[:through]

                rel = @registro.send(r.name)
                next if rel.count <= 0

                nom = rel[0].class.human_attribute_name(r.name)
                mens += " Este registro se relaciona con " \
                  "#{rel.count} registro(s) '#{nom}' (con id(s) " \
                  "#{rel.map(&:id).join(", ")}), " \
                  "no puede eliminarse aún. "
              end
              m = @registro.class.reflect_on_all_associations(:has_and_belongs_to_many)
              m.each do |r|
                next if r.options[:through]

                rel = @registro.send(r.name)
                next if rel.count <= 0

                nom = rel[0].class.human_attribute_name(r.name)
                mens += " Este registro se relaciona con " \
                  "#{rel.count} registro(s) '#{nom}' (con id(s) " \
                  "#{rel.map(&:id).join(", ")}), " \
                  "no puede eliminarse aún. "
              end

              if mens != ""
                redirect_back(
                  fallback_location: main_app.root_path,
                  flash: { error: mens },
                )
                return
              end
            end
            cregistro = @registro.class.to_s
            cregistroid = @registro.id
            @registro.destroy
            if registrar_en_bitacora
              Msip::Bitacora.a(
                request.remote_ip,
                current_usuario.id,
                request.url,
                params,
                cregistro,
                cregistroid,
                "eliminar",
                "",
              )
            end

            eliminada = genclase == "M" ? "eliminado" : "eliminada"
            respond_to do |format|
              format.html do
                redirect_to(
                  modelos_url(@registro),
                  status: :see_other, # Evita doble DELETE, que ocurre esporadicamente, solución de https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
                  notice: clase + " #{eliminada}.",
                )
                return
              end
              format.json do
                head(:no_content)
                return
              end
            end
          end

          # Elimina
          def destroy(mens = "", verifica_tablas_union = true)
            destroy_gen(mens, verifica_tablas_union)
          end

          # Nombre del modelo
          def clase
            "Msip::ModelosCambiar"
          end

          # Genero del modelo (F - Femenino, M - Masculino)
          def genclase
            "F"
          end

          # Campos de la tabla por presentar en listado
          def atributos_index
            [
              "id",
              "created_at",
              "updated_at",
            ]
          end

          def atributos_filtro_antestabla
            []
          end

          # Campos por mostrar en presentación de un registro
          def atributos_show
            atributos_index
          end

          # Campos que se presentar en formulario
          def atributos_form
            atributos_show -
              ["id", :id, "created_at", :created_at, "updated_at", :updated_at]
          end

          # Campos por retornar como API JSON
          def atributos_show_json
            atributos_show
          end

          helper_method :clase,
            :atributos_index,
            :atributos_filtro_antestabla,
            :atributos_form,
            :atributos_show,
            :atributos_show_json,
            :genclase
        end # included
      end
    end
  end
end
