# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module PersonasController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          before_action :prepara_persona, 
            only: [:show, :edit, :update, :destroy]

          def clase
            "Msip::Persona"
          end

          def genclase
            "F"
          end

          def atributos_show_msip
            [
              :id,
              :nombres,
              :apellidos,
              :anionac,
              :mesnac,
              :dianac,
              :sexo,
              :etnia,
              :pais,
              :departamento,
              :municipio,
              :centropoblado,
              :nacionalde,
              :tdocumento_id,
              :numerodocumento,
              :etiqueta_ids,
              :familiares
            ]
          end

          def atributos_show
            atributos_show_msip
          end

          def atributos_index_msip
            atributos_show_msip - [:familiares]
          end

          def atributos_index
            atributos_index_msip
          end

          def atributos_form_msip
            a = atributos_show_msip - [:etiqueta_ids, :familiares] + 
              [:persona_trelacion1] + [
                etiqueta_ids: []
              ]
            a
          end

          def atributos_form
            atributos_form_msip
          end

          def atributos_html_encabezado_formulario
            { "data-controller": "msip--sindocaut" }
          end

          def index_msip(c = nil)
            if c.nil?
              c = Msip::Persona.all
            end
            if params[:term]
              consNomvic = Msip::SqlHelper.cadena_a_palabras_tsquery(
                params[:term]
              )
              where = " to_tsvector('spanish', unaccent(persona.nombres) " \
                " || ' ' || unaccent(persona.apellidos) " \
                " || ' ' || COALESCE(persona.numerodocumento::TEXT, '')) @@ " \
                "to_tsquery('spanish', '#{consNomvic}')"

              partes = [
                "nombres",
                "apellidos",
                "COALESCE(numerodocumento::TEXT, '')",
              ]
              s = ""
              l = " persona.id "
              seps = ""
              sepl = " || ';' || "
              partes.each do |p|
                s += seps + p
                l += sepl + "char_length(#{p})"
                seps = " || ' ' || "
              end
              qstring = "SELECT TRIM(#{s}) AS value, #{l} AS id
              FROM public.msip_persona AS persona
              WHERE #{where} ORDER BY 1 LIMIT 10"

              r = ActiveRecord::Base.connection.select_all(qstring)
              respond_to do |format|
                format.json { render(:json, inline: r.to_json) }
                format.html { render(inline: "No responde con parametro term") }
              end
            else
              super(c)
            end
          end

          def index(c = nil)
            index_msip(c)
          end

          def remplazar
          end

          def datos_complementarios(oj)
            return oj
          end

          # API
          def datos
            return unless params[:persona_id]

            @persona = Msip::Persona.find(params[:persona_id].to_i)
            authorize!(:read, @persona)
            oj = {
              id: @persona.id,
              nombres: @persona.nombres,
              apellidos: @persona.apellidos,
              sexo: @persona.sexo,
              tdocumento: if @persona.tdocumento
                            @persona.tdocumento.sigla
                          else
                            ""
                          end,
              numerodocumento: @persona.numerodocumento,
              dianac: @persona.dianac,
              mesnac: @persona.mesnac,
              anionac: @persona.anionac,
            }
            ## Si está autocompletando una persona de orgsocial persona
            # entonces autcompletar cargo y correo
            if params[:ac_orgsocial_persona]
              orgsocial_persona = Msip::OrgsocialPersona.find_by(persona_id: @persona.id)
              if orgsocial_persona
                oj[:cargo] = orgsocial_persona.cargo
                oj[:correo] = orgsocial_persona.cargo
              end
            end
            oj = datos_complementarios(oj)
            respond_to do |format|
              format.json { render(json: oj, status: :ok) }
              format.html { render(inilne: oj.to_s, status: :ok) }
            end
          end

          # Retorna una identificación para tipo de documento SIN DOCUMENTO
          # para una persona en base
          def identificacionsd
            pid = nil
            if params && params[:persona_id] && params[:persona_id] != ""
              pid = params[:persona_id].to_i
            end
            indice = nil
            if params && params[:indice] && params[:indice] != ""
              indice = params[:indice].to_i
            end
            ndoc = Msip::PersonasController
              .nueva_persona_sd_posible_numerodocumento(pid, indice)
            Rails.logger.debug { "OJO ndoc=#{ndoc}" }
            respond_to do |format|
              format.json do
                render(inline: ndoc)
                return
              end
              format.html do
                render(inline: ndoc)
                return
              end
            end
          end

          # Retorna una propuesta para número de documento con base
          # en la id de la persona (no nil)
          def self.mejora_nuevo_numerodocumento_sindoc(
            numdoc, persona_id
          )
            numerodocumento = numdoc #% 2147483647 # Max. INTEGER de PostgreSQL
            while Msip::Persona.where(
              tdocumento_id: 11, numerodocumento: numerodocumento,
            ).where("id<>?", persona_id).count > 0
              numerodocumento = numerodocumento.to_s
              if !numerodocumento.empty? && numerodocumento[-1] >= "A" &&
                  numerodocumento[-1] < "Z"
                ul = numerodocumento[-1].ord + 1
                numerodocumento = numerodocumento[0..-2] + ul.chr(Encoding::UTF_8)
              else
                numerodocumento += "A"
              end
            end
            numerodocumento
          end

          def validar_conjunto_familiar_diferente(validaciones)
            cp = Msip::PersonaTrelacion.joins(:personauno).
              where('persona1=persona2')
            if cp.count > 0 
              validaciones << {
                titulo: "Personas familiares de si mismas",
                encabezado: ["Código", "Nombres", "Apellidos", "Relación"],
                cuerpo: cp.pluck(:id, :nombres, :apellidos, :trelacion_id),
                enlaces: cp.map {|p| msip.edit_persona_path(p.id)}
              }
            end
          end

          def lista_validaciones_conjunto
            [:validar_conjunto_familiar_diferente]
          end

          def prepara_persona
            if params && params[:id] &&
                Msip::Persona.where(id: params[:id]).count > 0
              @persona = Msip::Persona.find(params[:id])
            else
              @persona = Msip::Persona.new
            end
            @registro = @persona
          end
          alias_method :set_persona, :prepara_persona

          def lista_params_msip
            atributos_form + [
              :pais_id,
              :departamento_id,
              :municipio_id,
              :centropoblado_id,
              :tdocumento_id,
              :etnia_id,
            ] + [ 
              etiqueta_persona_attributes:  [
                :etiqueta_id, 
                :fecha_localizada,
                :id,
                :observaciones,
                :usuario_id,
                :_destroy
              ],
              persona_trelacion1_attributes:  [
                :id,
                :trelacion_id,
                :_destroy,
                :personados_attributes => [
                  :id,
                  :nombres, 
                  :apellidos,
                  :sexo,
                  :tdocumento_id,
                  :numerodocumento,
                ]
              ]
            ]
          end

          def lista_params
            lista_params_msip
          end

          def persona_params
            params.require(:persona).permit(lista_params)
          end
        end # include

        class_methods do

          #def nueva_persona_sd_posible_numerodocumento(persona_id)
          #  rand(10000).to_s + "AAA"
          #end

          def nueva_persona_sd_posible_numerodocumento(
            persona_id, indice=nil
          )
            if persona_id.nil?
              ruid = Msip::Persona.connection.execute(<<-SQL.squish)
                  SELECT last_value FROM msip_persona_id_seq;
              SQL
              persona_id = ruid[0]["last_value"] + 1
            end
            numerodocumento = mejora_nuevo_numerodocumento_sindoc(
              persona_id.to_s+indice.to_s, persona_id
            )
            numerodocumento
          end

          def nueva_persona_valores_predeterminados(menserror)
            numerodocumento = nueva_persona_sd_posible_numerodocumento(
              nil,
            )
            persona = Msip::Persona.create(
              nombres: "N",
              apellidos: "N",
              sexo: Msip::Persona.convencion_sexo[:sexo_sininformacion],
              tdocumento_id: 11, # SIN DOCUMENTO
              numerodocumento: numerodocumento,
            )
            if !persona.save(validate: false)
              menserror << 'No pudo crear persona'
              return nil
            end
            persona
          end


        end
      end
    end
  end
end
