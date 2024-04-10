# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Persona
        extend ActiveSupport::Concern
        include Msip::Modelo
        include Msip::Localizacion

        included do
          self.table_name = "msip_persona"

          CONVENCIONES_SEXO = {
            "FMS" => {
              sexo_femenino: :F,
              nombre_femenino: "FEMENINO",
              sexo_masculino: :M,
              nombre_masculino: "MASCULINO",
              sexo_sininformacion: :S,
              nombre_sininformacion: "SIN INFORMACIÓN",
            },
            "MHS" => {
              sexo_femenino: :M,
              nombre_femenino: "MUJER",
              sexo_masculino: :H,
              nombre_masculino: "HOMBRE",
              sexo_sininformacion: :S,
              nombre_sininformacion: "SIN INFORMACIÓN",
            },
            "MHSI" => {
              sexo_femenino: :M,
              nombre_femenino: "MUJER",
              sexo_masculino: :H,
              nombre_masculino: "HOMBRE",
              sexo_sininformacion: :S,
              nombre_sininformacion: "SIN INFORMACIÓN",
              sexo_intersexual: :I,
              nombre_intersexual: "INTERSEXUAL",
            },
            "MHO" => {
              sexo_femenino: :M,
              nombre_femenino: "MUJER",
              sexo_masculino: :H,
              nombre_masculino: "HOMBRE",
              sexo_sininformacion: :O,
              nombre_sininformacion: "OTRO",
            },
            "MHSO" => {
              sexo_femenino: :M,
              nombre_femenino: "MUJER",
              sexo_masculino: :H,
              nombre_masculino: "HOMBRE",
              sexo_sininformacion: :S,
              nombre_sininformacion: "SIN INFORMACIÓN",
              sexo_intersexual: :O,
              nombre_intersexual: "OTRO",
            },

          }

          # Retorna cadena con convención para sexo en base
          # Bien FMS o bien MHS o bien MHO
          def self.convencion_sexo_abreviada
            # La convención se almacena en base de datos en la constraint
            # persona_sexo_check de tabla msip_persona
            r = Msip::Persona.connection.execute(
              "SELECT "\
                "substring(pg_get_constraintdef(oid, TRUE) FROM '''([^'']*)''') "\
                "  FROM pg_constraint "\
                "  WHERE conrelid='msip_persona'::regclass "\
                "    AND conname='persona_sexo_check'; ",
            )[0]["substring"]
            puts "r=", r

            unless CONVENCIONES_SEXO.keys.include?(r)
              $stderr.puts "** Convención en base para sexo desconocida: #{r}, usando FMS"
              r = "FMS"
            end

            r
          end

          def self.convencion_sexo
            r = convencion_sexo_abreviada
            CONVENCIONES_SEXO[r]
          end

          # Retorna arreglo con convenciones es de la forma
          # [
          #   ['SIN INFORMACIÓN', :S]
          #   ['FEMENINO', :F]
          #   ['MASCULINO', :M]
          # ]
          def self.sexo_opciones
            dc = convencion_sexo
            if dc.length == 6
              [
                [dc[:nombre_sininformacion], dc[:sexo_sininformacion].to_sym],
                [dc[:nombre_femenino], dc[:sexo_femenino].to_sym],
                [dc[:nombre_masculino], dc[:sexo_masculino].to_sym],
              ]
            elsif dc.length == 8
              [
                [dc[:nombre_sininformacion], dc[:sexo_sininformacion].to_sym],
                [dc[:nombre_femenino], dc[:sexo_femenino].to_sym],
                [dc[:nombre_masculino], dc[:sexo_masculino].to_sym],
                [dc[:nombre_intersexual], dc[:sexo_intersexual].to_sym],
              ]
            else
              raise "Convención no manejada: #{dc}"
            end
          end

          def self.sexo_opciones_cortas
            dc = convencion_sexo
            if dc.length == 6
              [
                [dc[:sexo_sininformacion].to_s, dc[:sexo_sininformacion].to_sym],
                [dc[:sexo_femenino].to_s, dc[:sexo_femenino].to_sym],
                [dc[:sexo_masculino].to_s, dc[:sexo_masculino].to_sym],
              ]
            elsif dc.length == 8
              [
                [dc[:sexo_sininformacion].to_s, dc[:sexo_sininformacion].to_sym],
                [dc[:sexo_femenino].to_s, dc[:sexo_femenino].to_sym],
                [dc[:sexo_masculino].to_s, dc[:sexo_masculino].to_sym],
                [dc[:sexo_intersexual].to_s, dc[:sexo_intersexual].to_sym],
              ]
            else
              raise "Convención no manejada: #{dc}"
            end
          end

          # Retorna diccionario con convenciones sobre sexo de la forma
          # {
          #   :S => 'SIN INFORMACIÓN',
          #   :F => 'FEMENINO',
          #   :M => 'MASCULINO'
          # }
          def self.sexo_opciones_diccionario
            dc = convencion_sexo
            if dc.length == 6
              [
                [dc[:sexo_sininformacion].to_sym, dc[:nombre_sininformacion]],
                [dc[:sexo_femenino].to_sym, dc[:nombre_femenino]],
                [dc[:sexo_masculino].to_sym, dc[:nombre_masculino]],
              ].to_h
            elsif dc.length == 8
              [
                [dc[:sexo_sininformacion].to_sym, dc[:nombre_sininformacion]],
                [dc[:sexo_femenino].to_sym, dc[:nombre_femenino]],
                [dc[:sexo_masculino].to_sym, dc[:nombre_masculino]],
                [dc[:sexo_intersexual].to_sym, dc[:nombre_intersexual]],
              ].to_h
            else
              raise "Convención no manejada: #{dc}"
            end
          end

          ORIENTACION_OPCIONES = [
            ["SIN INFORMACIÓN", :S],
            ["HETEROSEXUAL", :H],
            ["LESBIANA", :L],
            ["GAY", :G],
            ["BISEXUAL", :B],
            ["TRANSEXUAL", :T],
            ["LGBTQ+", :O],
          ]

          def self.orientacion_opciones_diccionario
            Msip::Persona::ORIENTACION_OPCIONES.map { |e| [e[1], e[0]] }.to_h
          end

          # Bien sea o no con inverse_of aqui y/o en orgsocial_persona
          has_many :orgsocial_persona,
            foreign_key: "persona_id",
            class_name: "Msip::OrgsocialPersona",
            validate: true
          # inverse_of: :persona
          
          belongs_to :centropoblado,
            class_name: "Msip::Centropoblado",
            validate: true,
            optional: true

          belongs_to :nacional,
            class_name: "Msip::Pais",
            foreign_key: "nacionalde",
            validate: true,
            optional: true

          belongs_to :departamento,
            validate: true,
            class_name: "Msip::Departamento",
            optional: true

          belongs_to :etnia,
            validate: true,
            class_name: "Msip::Etnia",
            optional: false 

          belongs_to :municipio,
            validate: true,
            class_name: "Msip::Municipio",
            optional: true

          belongs_to :pais,
            class_name: "Msip::Pais",
            validate: true,
            optional: true

          belongs_to :tdocumento,
            class_name: "Msip::Tdocumento",
            validate: true,
            optional: true

          has_many :etiqueta_persona,  
            foreign_key: 'persona_id',
            validate: true,
            dependent: :destroy,
            class_name: 'Msip::EtiquetaPersona'
          has_many :etiqueta, 
            through: :etiqueta_persona, 
            class_name: 'Msip::Etiqueta'
          accepts_nested_attributes_for :etiqueta_persona, 
            allow_destroy: true, 
            reject_if: :all_blank

          has_many :persona_trelacion1,
            foreign_key: "persona1",
            dependent: :delete_all,
            class_name: "Msip::PersonaTrelacion"
          has_many :persona_trelacion2,
            foreign_key: "persona2",
            dependent: :delete_all,
            class_name: "Msip::PersonaTrelacion"

          has_many :personados,
            through: :persona_trelacion1,
            class_name: "Msip::Persona"
          accepts_nested_attributes_for :personados, reject_if: :all_blank
          accepts_nested_attributes_for :persona_trelacion1,
            reject_if: :all_blank,
            allow_destroy: true

          # identificación autogenerada en este y demás modelos (excepto los de
          # información geográfica).
          validates :nombres,
            presence: true,
            allow_blank: false,
            length: { maximum: 100 }
          validates :apellidos,
            presence: true,
            allow_blank: false,
            length: { maximum: 100 }
          validates :numerodocumento, length: { maximum: 100 }
          validates :sexo, presence: true
          validates :anionac, numericality: { allow_blank: true }
          validates :mesnac, numericality: { allow_blank: true }
          validates :dianac, numericality: { allow_blank: true }
          validate :vfechanac
          validate :vformatonumdoc


          def vfechanac
            anioactual = Time.now.strftime("%Y").to_i
            if anionac && anionac > anioactual
              errors.add(:anionac, "Año debe ser menor al actual")
            end
            if anionac && anionac < 1900
              errors.add(:anionac, "Año debe ser mayor o igual a 1900")
            end
            if mesnac && (mesnac < 1 || mesnac > 12)
              errors.add(:mesnac, "Mes debe estar entre 1 y 12")
            end
            if dianac && dianac < 1
              errors.add(:dianac, "Dia debe ser positivo")
            end
            if dianac && mesnac && mesnac == 2 && dianac > 29
              errors.add(:dianac, "Dia debe ser menor o igual a 29")
            elsif anionac && mesnac && dianac && mesnac == 2 && dianac == 29
              ud = Date.civil(anionac, mesnac, -1)
              if dianac > ud.day
                errors.add(:dianac, "Dia debe ser menor o igual a #{ud.day}")
              end
            elsif dianac && mesnac && (mesnac == 4 || mesnac == 6 ||
                                        mesnac == 9 || mesnac == 11) &&
                dianac > 30
              errors.add(:dianac, "Dia debe ser menor o igual a 30")
            elsif dianac && dianac > 31
              errors.add(:dianac, "Dia debe ser menor o igual a 31")
            end
          end

          def vformatonumdoc
            if tdocumento && tdocumento.formatoregex != "" &&
                !(numerodocumento =~ Regexp.new("^#{tdocumento.formatoregex}$"))
              menserr = "Número de documento con formato errado."
              if tdocumento.ayuda
                menserr += " #{tdocumento.ayuda}"
              end
              errors.add(:numerodocumento, menserr)
            end
          end


          def fechanac
            r = ""
            r += anionac.to_s if anionac
            r += "-"
            r += FormatoFechaHelper::ABMESES[mesnac] if mesnac &&
              mesnac >= 1 && mesnac <= 12
            r += "-"
            r += dianac.to_s if dianac
            r
          end

          def presenta_fechanac
            r = ""
            r += dianac.to_s if dianac
            r += "/"
            r += FormatoFechaHelper::ABMESES[mesnac] if mesnac &&
              mesnac >= 1 && mesnac <= 12
            r += "/"
            r += anionac.to_s if anionac
            r
          end

          def fechanac_localizada
            presenta_fechanac
          end

          def presenta_nombre
            r = nombres + " " + apellidos
            r.strip
          end

          def msip_presenta(atr)
            case atr.to_s
            when "centro_poblado"
              centropoblado ? centropoblado.nombre : ""
            when "nacionalde"
              nacionalde ? nacional.nombre : ""
            when "sexo"
              ds = Msip::Persona.sexo_opciones_diccionario
              ds[sexo.to_sym] || "Sexo desconocido"
            when "tdoc"
              tdocumento&.sigla
            else
              presenta_gen(atr)
            end
          end

          def presenta(atr)
            msip_presenta(atr)
          end

          def importa_msip(datosent, datossal, menserror, opciones = {})
            unless datosent.key?(:sexo)
              self.sexo = "S"
            end

            if datosent[:fechanac]
              r = datosent[:fechanac]
              # suponemos yyyy-mm-dd
              d = Msip::FormatoFechaHelper.reconoce_adivinando_locale(r, menserror)
              if d
                self.dianac = d.day
                self.mesnac = d.month
                self.anionac = d.year
              end
              datosent.delete(:fechanac)
            end

            if datosent[:fechanac_localizada]
              r = datosent[:fechanac_localizada]
              # suponemos dd/M/yyy
              d = Msip::ImportaHelper.fecha_local_colombia_a_date(r, menserror)
              if d
                self.dianac = d.day
                self.mesnac = d.month
                self.anionac = d.year
              end
              datosent.delete(:fechanac_localizada)
            end
            if datosent[:tdocumento]
              d = Msip::ImportaHelper.nombre_en_tabla_basica(
                Msip::Tdocumento, datosent[:tdocumento], menserror
              )
              unless d.nil?
                self.tdocumento_id = d.id
              end
              datosent.delete(:tdocumento)
            end
            if datosent[:pais]
              pais = Msip::ImportaHelper.nombre_en_tabla_basica(
                Msip::Pais, datosent[:pais].upcase, menserror
              )
              self.pais_id = pais ? pais.id : nil
              datosent.delete(:pais)
            end
            if datosent[:departamento]
              if datosent[:departamento] != ""
                if pais_id.nil?
                  self.pais_id = Msip::Pais.where(nombre: "COLOMBIA").take.id
                end
                d = Msip::Departamento.where(pais_id: pais_id).where(
                  "upper(unaccent(nombre)) = upper(unaccent(?))",
                  datosent[:departamento].upcase,
                )
                if d.count == 0
                  menserror << "  No se encontró departamento '#{datosent[:departamento]}' en el pais '#{Msip::Pais.find(pais_id).nombre}'."
                else
                  self.departamento_id = d.take.id
                end
              end
              datosent.delete(:departamento)
            end

            if datosent[:municipio]
              if datosent[:municipio] != ""
                if departamento_id.nil?
                  menserror << "  No se puede ubicar municipio #{datosent[:municipio]} sin departamento."
                else
                  m = Msip::Municipio.where(
                    departamento_id: departamento_id,
                  ).where(
                    "upper(unaccent(nombre)) = upper(unaccent(?))",
                    datosent[:municipio].upcase,
                  )
                  if m.count == 0
                    menserror << "  No se encontró municipio #{datosent[:municipio]} en el departamento #{Msip::Departamento.find(departamento_id).nombre}."
                  else
                    self.municipio_id = m.take.id
                  end
                end
              end
              datosent.delete(:municipio)
            end

            if datosent.keys.include?(:centro_poblado)
              if datosent[:centro_poblado] && datosent[:centro_poblado] != ""
                if municipio_id.nil?
                  menserror << "  No puede ubicarse centro_poblado #{datosent[:centro_poblado]} sin municipio."
                else
                  cp = Msip::Centropoblado.where(
                    municipio_id: municipio_id,
                  ).where(
                    "upper(unaccent(nombre))=upper(unaccent(?))",
                    datosent[:centro_poblado].upcase,
                  )
                  if cp.count == 0
                    menserror << "  No se encontró centro poblado #{datosent[:centro_poblado]} en el municipio #{Msip::Municipio.find(municipio_id).nombre}."
                  else
                    self.centropoblado_id = cp.take.id
                  end
                end
              end
              datosent.delete(:centro_poblado)
            end

            if datosent[:nacionalde]
              self.nacionalde = Msip::ImportaHelper.nombre_en_tabla_basica(
                Msip::Pais, datosent[:nacionalde].upcase, menserror
              )
              datosent.delete(:nacionalde)
            end

            importa_gen(datosent, datossal, menserror, opciones)
          end

          def importa(datosent, datossal, menserror, opciones = {})
            importa_msip(datosent, datossal, menserror, opciones)
          end


          scope :filtro_anionac, lambda { |anionac|
            where("anionac = ?", anionac.to_i)
          }

          # En apellido si busca cadena entre comillas la busca completa
          # por ejemplo "N" busca apellidos N
          # Mientras que N busca apellidos que incluyan N
          scope :filtro_apellidos, lambda { |a|
            if a.match("^ *\"(.*)\" *$")
              where("unaccent(apellidos) ILIKE unaccent(?)", ::Regexp.last_match(1))
            else
              where("unaccent(apellidos) ILIKE '%' || unaccent(?) || '%'", a)
            end
          }

          scope :filtro_centropoblado, lambda { |cid|
            where(centropoblado_id: cid.to_i)
          }
 
          scope :filtro_departamento, lambda { |did|
            where(departamento_id: did.to_i)
          }
 
          scope :filtro_dianac, lambda { |dianac|
            where("dianac = ?", dianac.to_i)
          }

          scope :filtro_etiqueta_ids, lambda {|e|
            joins(:etiqueta_persona).
              where("msip_etiqueta_persona.etiqueta_id": e.to_i)
          }

          scope :filtro_etnia, lambda { |ide|
            where("etnia_id = ?", ide.to_i)
          }

          scope :filtro_mesnac, lambda { |mesnac|
            if mesnac != "0"
              where("mesnac = ?", mesnac.to_i)
            end
          }

          scope :filtro_municipio, lambda { |mid|
            where(municipio_id: mid.to_i)
          }

          scope :filtro_nacionalde, lambda { |idp|
            where(nacionalde: idp.to_i)
          }

          # En nombre si busca cadena entre comillas la busca completa
          # por ejemplo "N" busca nombres N
          # Mientras que N busca nombres que incluyan N
          scope :filtro_nombres, lambda { |n|
            if n.match("^ *\"(.*)\" *$")
              where("unaccent(nombres) ILIKE unaccent(?)", ::Regexp.last_match(1))
            else
              where("unaccent(nombres) ILIKE '%' || unaccent(?) || '%'", n)
            end
          }

          scope :filtro_numerodocumento, lambda { |n|
            where(
              "unaccent(numerodocumento) ILIKE '%' || " \
                "unaccent(?) || '%'",
              n,
            )
          }

          scope :filtro_pais, lambda { |pid|
            where(pais_id: pid.to_i)
          }

          scope :filtro_sexo, lambda { |s|
            where(sexo: s)
          }

          scope :filtro_tdocumento_id, lambda { |tid|
            where(tdocumento_id: tid.to_i)
          }

        end # include

        class_methods do
        end
      end # Persona
    end # Models
  end # Concerns
end # Msip
