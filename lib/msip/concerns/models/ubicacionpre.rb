# frozen_string_literal: true

module Msip
  module Concerns
    module Models
      module Ubicacionpre
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          self.table_name = "msip_ubicacionpre"

          belongs_to :pais,
            class_name: "Msip::Pais",
            validate: true,
            optional: true
          belongs_to :departamento,
            class_name: "Msip::Departamento",
            validate: true,
            optional: true
          belongs_to :municipio,
            class_name: "Msip::Municipio",
            validate: true,
            optional: true
          belongs_to :centropoblado,
            class_name: "Msip::Centropoblado",
            validate: true,
            optional: true
          belongs_to :vereda,
            class_name: "Msip::Vereda",
            validate: true,
            optional: true
          belongs_to :tsitio,
            class_name: "Msip::Tsitio",
            validate: true,
            optional: true

          flotante_localizado :latitud
          flotante_localizado :longitud

          validates :nombre,
            uniqueness: true,
            presence: true,
            length: { maximum: 2000 }
          validates :nombre_sin_pais,
            length: { maximum: 2000 }

          validates :lugar, length: { maximum: 500 }
          validates :sitio, length: { maximum: 500 }

          validates :pais_id, presence: true

          validate :centropoblado_nand_vereda
          def centropoblado_nand_vereda
            if centropoblado_id and vereda_id
              errors.add(
                :centropoblado, "No puede tener centro poblado y vereda"
              )
            end
          end

          validate :llave_tsitio
          # Evita errores como
          # PG::ForeignKeyViolation: ERROR: insert or update on table
          # "msip_ubicacionpre" violates foreign key constraint
          # "fk_rails_c8024a90df"
          # DETAIL: Key (tsitio_id)=(14) is not present in table "msip_tsitio".
          def llave_tsitio
            if tsitio_id && Msip::Tsitio.where(id: tsitio_id).count != 1
              errors.add(
                :tsitio_id, "Elegir un tipo de sitio válido"
              )
            end
          end

          # Evita errores como:
          # PG::ForeignKeyViolation: ERROR: insert or update on table
          # "msip_ubicacionpre" violates foreign key constraint
          # "fk_ubicacionpre_pais_departamento"
          # DETAIL: Key (pais_id, departamento_id)=(170, 9) is not present in
          # table "msip_departamento"
          validate :par_pais_departamento
          def par_pais_departamento
            if pais_id && departamento_id
              if Msip::Departamento.where(
                pais_id: pais_id,
                id: departamento_id,
              ).count != 1
                errors.add(
                  :departamento_id, "El departamento debe pertenecer al país"
                )
              end
            end
          end

          validate :par_departamento_municipio
          def par_departamento_municipio
            if (centropoblado_id || vereda_id || municipio_id) &&
                !departamento_id
              errors.add(
                :departamento_id, "Falta departamento"
              )
            end
            if departamento_id && municipio_id
              if Msip::Municipio.where(
                departamento_id: departamento_id,
                id: municipio_id,
              ).count != 1
                errors.add(
                  :municipio_id, "El municipio debe pertenecer al departamento"
                )
              end
            end
          end

          validate :par_municipio_centropoblado
          def par_municipio_centropoblado
            if (centropoblado_id || vereda_id) && !municipio_id
              errors.add(
                :municipio_id, "Falta municipio"
              )
            end
            if municipio_id && centropoblado_id
              if Msip::Centropoblado.where(
                municipio_id: municipio_id,
                id: centropoblado_id,
              ).count != 1
                errors.add(
                  :centropoblado_id,
                  "El centropoblado debe pertenecer al municipio",
                )
              end
            end
          end

          validate :par_municipio_vereda
          def par_municipio_vereda
            if municipio_id && vereda_id
              if Msip::Vereda.where(
                municipio_id: municipio_id,
                id: vereda_id,
              ).count != 1
                errors.add(
                  :vereda_id, "El vereda debe pertenecer al municipio"
                )
              end
            end
          end

          def poner_nombre_estandar
            self.nombre, self.nombre_sin_pais = Msip::Ubicacionpre.nomenclatura(
              pais.nombre,
              departamento ? departamento.nombre : "",
              municipio ? municipio.nombre : "",
              centropoblado ? centropoblado.nombre : "",
              vereda ? vereda.nombre : "",
              lugar,
              sitio,
            )
            save
          end
        end # include

        class_methods do
          # Corresponde a función PostgreSQL msip_ubicacionpre_nomenclatura
          def nomenclatura(pais, departamento, municipio,
            centropoblado, vereda, lugar, sitio)
            if pais.to_s.strip == ""
              return ["", ""]
            end

            if departamento.to_s.strip == ""
              nombre = pais.to_s.strip
              nombre_sinp = ""
            elsif municipio.to_s.strip == ""
              nombre = departamento.to_s.strip + " / " + pais.to_s.strip
              nombre_sinp = departamento.to_s.strip
            elsif vereda.to_s.strip == "" && centropoblado.to_s.strip == ""
              nombre = municipio.to_s.strip + " / " +
                departamento.to_s.strip + " / "  + pais.to_s.strip
              nombre_sinp = municipio.to_s.strip + " / " +
                departamento.to_s.strip
            elsif vereda.to_s.strip != ""
              nombre = "Vereda " + vereda.to_s.strip + " / " +
                municipio.to_s.strip + " / " +
                departamento.to_s.strip + " / " + pais.to_s.strip
              nombre_sinp = "Vereda " + vereda.to_s.strip + " / " +
                municipio.to_s.strip + " / " +
                departamento.to_s.strip
            else # centropoblado != ""
              nombre = centropoblado.to_s.strip + " / " +
                municipio.to_s.strip + " / " +
                departamento.to_s.strip + " / " + pais.to_s.strip
              nombre_sinp = centropoblado.to_s.strip + " / " +
                municipio.to_s.strip + " / " +
                departamento.to_s.strip
            end
            if lugar.to_s.strip != ""
              nombre = lugar.to_s.strip + " / " + nombre
              nombre_sinp = lugar.to_s.strip +
                (nombre_sinp != "" ? " / " + nombre_sinp.to_s : "")
              if sitio.to_s.strip != ""
                nombre = sitio.to_s.strip + " / " + nombre
                nombre_sinp = sitio.to_s.strip + " / " + nombre_sinp
              end
            end
            [nombre, nombre_sinp]
          end

          def buscar_o_agregar_divipola(
            opais, odepartamento, omunicipio, 
            ocentropoblado, overeda, dlatitud, dlongitud
          )
            w = {
              pais_id: opais.id,
              departamento_id: odepartamento ? odepartamento.id : nil,
              municipio_id: omunicipio ? omunicipio.id : nil,
              centropoblado_id: ocentropoblado ? ocentropoblado.id : nil,
              vereda_id: overeda ? overeda.id : nil
            }
            ubi = Msip::Ubicacionpre.where(w)
            if ubi.count > 1
              Rails.logger.debug(
                "Se esperaba una sola ubicacionpre, se encontraron #{ubi}"
              )
              return
            end
            if ubi.count == 1
              return ubi[0].id
            end
            w[:latitud] = dlatitud
            w[:longitud] = dlongitud
            w[:nombre], w[:nombre_sin_pais] = Msip::Ubicacionpre.nomenclatura(
              opais.nombre,
              odepartamento ? odepartamento.nombre : "",
              omunicipio ? omunicipio.nombre : "",
              overeda ? overeda.nombre : "",
              ocentropoblado ? ocentropoblado.nombre : "",
              "",
              ""
            )

            nubi = Msip::Ubicacionpre.create!(w)
            return nubi.id
          end

          # A partir de datos como para ubicacionpre los valida
          # y crea una ubicacionpre y retorna su id o retorna id de una
          # ubicación existente hasta donde logre validar.
          #
          # @param pais_id id de país
          # @param departamento_id id de departamento
          # @param municipio_id id de municipio
          # @param centropoblado_id id del centro poblado
          # @param vereda_id id del centro poblado
          # @param lugar lugar
          # @param sitio sitio
          # @param tsitio_id tipo de sitio
          # @param latitud Latitud no localizada
          # @param longitud Longitud no localizada
          # @param usa_latlon Si usa_latlon es falso y la ubicación con lugar
          #   es válida ignora las que recibe y pone unas de acuerdo al pais,
          #   departamento, municipio y centropoblado.
          # @return id de ubicación que encuentra o que crea o nil si
          #   tiene problema
          def buscar_o_agregar(pais_id, departamento_id, municipio_id,
            centropoblado_id, vereda_id, lugar, sitio, tsitio_id,
            latitud, longitud,
            usa_latlon = true)
            longitud = usa_latlon ? longitud.to_f : 0.0

            if !pais_id
              Rails.logger.debug("Problema, ubicacionpre debe tener al menos pais")
              return nil
            end
            if Msip::Pais.where(id: pais_id.to_i).count == 0
              Rails.logger.debug("Problema, pais_id desconocido")
              return nil
            end
            opais = Msip::Pais.find(pais_id.to_i)
            # Aquí debería chequearse que la latitud y longitud estén
            # dentro del país
            if (latitud.to_f == 0.0 &&
                longitud.to_f == 0.0) ||
                !usa_latlon
              latitud = opais.latitud
              longitud = opais.longitud
            end

            w = {
              pais_id: opais.id,
              departamento_id: nil,
              municipio_id: nil,
              centropoblado_id: nil,
              vereda_id: nil,
              tsitio_id: nil,
              lugar: nil,
              sitio: nil,
            }
            if departamento_id.to_i > 0 && Msip::Departamento.where(
                id: departamento_id.to_i,
                pais_id: opais.id,
            ).count == 0
              Rails.logger.debug(
                "Problema, departamento_id no valido #{departamento_id}"
              )
              return nil
            end
            w[:departamento_id] = departamento_id
            odepartamento = departamento_id.to_i > 0 ? 
              Msip::Departamento.find(departamento_id.to_i) : nil

            if (departamento_id.nil? && !municipio_id.nil?) 
              Rails.logger.debug(
                "Problema, municipio_id es #{municipio_id} "\
                "pero departamento_id es nil"
              )
              return
            end
            if municipio_id.to_i > 0 && Msip::Municipio.where(
                id: municipio_id.to_i,
                departamento_id: odepartamento.id,
            ).count == 0
              Rails.logger.debug(
                "Problema, municipio_id no valido #{municipio_id}"
              )
              return nil
            end
            w[:municipio_id] = municipio_id
            omunicipio = municipio_id.to_i > 0 ? 
              Msip::Municipio.find(municipio_id.to_i) : nil

            if (centropoblado_id.to_i > 0 and vereda_id.to_i > 0)
              Rails.logger.debug(
                "Problema: centropoblado_id es #{centropoblado_id} y "\
                "vereda_id es #{vereda_id} que es inconsistencia"
              )
              return
            end

            if (municipio_id.to_i == 0 && centropoblado_id.to_i > 0) 
              Rails.logger.debug(
                "Problema, centropoblado_id es #{centropoblado_id} "\
                "pero municipio_id es nil"
              )
              return
            end
            if centropoblado_id.to_i > 0 && Msip::Centropoblado.where(
                id: centropoblado_id.to_i,
                municipio_id: omunicipio.id,
            ).count == 0
              Rails.logger.debug(
                "Problema, centropoblado_id no valido #{centropoblado_id}"
              )
              return nil
            end
            w[:centropoblado_id] = centropoblado_id
            ocentropoblado = centropoblado_id.to_i > 0 ? 
              Msip::Centropoblado.find(centropoblado_id.to_i) : nil

            if (municipio_id.to_i == 0 && vereda_id.to_i > 0) 
              Rails.logger.debug(
                "Problema, vereda_id es #{vereda_id} "\
                "pero municipio_id es nil"
              )
              return
            end
            if vereda_id.to_i > 0 && Msip::Vereda.where(
                id: vereda_id.to_i,
                municipio_id: omunicipio.id,
            ).count == 0
              Rails.logger.debug(
                "Problema, vereda_id no valido #{vereda_id}"
              )
              return nil
            end
            w[:vereda_id] = vereda_id
            overeda = vereda_id.to_i > 0 ? 
              Msip::Vereda.find(vereda_id.to_i) : nil

            # Latitud y longitud de DIVIPOLA
            dlatitud =opais.latitud
            dlongitud = opais.longitud
            if overeda
              dlatitud = overeda.latitud
              dlongitud = overeda.longitud
            elsif ocentropoblado
              dlatitud = ocentropoblado.latitud
              dlongitud = ocentropoblado.longitud
            elsif omunicipio
              dlatitud = omunicipio.latitud
              dlongitud = omunicipio.longitud
            elsif odepartamento
              dlatitud = odepartamento.latitud
              dlongitud = odepartamento.longitud
            end

            if sitio.to_s.strip == "" && lugar.to_s.strip == ""
              #  Es division politico administrativa dejamos
              #  lugar, sitio y tsitio_id en nil, latitud y longitud
              #  son las de la que tiene más resolución
              return buscar_o_agregar_divipola(
                opais, odepartamento, omunicipio, 
                ocentropoblado, overeda, dlatitud, dlongitud)
            end

            # Revisamos posible error en información de entrada que pondría
            # como lugar un centro poblado y en tal caso se retorna el centro
            # poblado
            if w[:centropoblado_id].to_i > 0 && Msip::Centropoblado.where(
              nombre: lugar.to_s.strip,
              municipio_id: omunicipio.id,
            ).count == 1
              ocentropoblado = Msip::Centropoblado.where(
                nombre: lugar.to_s.strip,
                municipio_id: omunicipio.id,
              ).first
              w[:centropoblado_id] = ocentropoblado.id
              if sitio.to_s.strip == ""
                Rails.logger.debug do
                  "Ajustando ubicacion sin centro poblado, ni sitio pero con " \
                    "lugar '#{lugar.to_s.strip} / #{omunicipio.nombre}', " \
                    "para que coincida con centro poblado del mismo nombre. "
                end
                return buscar_o_agregar_divipola(
                  opais, odepartamento, omunicipio, 
                  ocentropoblado, overeda, dlatitud, dlongitud)
              else
                Rails.logger.debug do
                  "** Ajustando ubicacion sin centro poblado, pero con sitio y " \
                    "con lugar igual a centro poblado " \
                    "'#{sitio.to_s.strip} / #{lugar.to_s.strip} / #{omunicipio.nombre}', " \
                    "para que el sitio sea lugar y lugar sea centro poblado " \
                    "necesitamos nombres únicos para ubicaciones/polígonos diferentes."
                end
                lugar = sitio.to_s.strip
                sitio = ""
              end
            end
            if sitio.to_s.strip == ""
              ubi = Msip::Ubicacionpre.where(w)
                .where("lugar ILIKE ?", lugar.strip.gsub(/  */, " "))
                .where("sitio IS NULL OR sitio=''")
              # puts w
              # puts ubi.to_sql
              if ubi.count > 0
                # modificando existente
                ubi[0].tsitio_id = tsitio_id
                ubi[0].latitud = latitud
                ubi[0].longitud = longitud
                if ubi[0].save
                  return ubi[0].id
                else
                  Rails.logger.debug { "Problema salvando ubi #{ubi[0]}" }
                  return
                end
              end
              # Preparamos para añadir nuevo
              w[:lugar] = lugar.strip.gsub(/  */, " ")
              w[:sitio] = ""
            else # Tiene sitio
              ubi = Msip::Ubicacionpre.where(w)
                .where("lugar ILIKE ?", lugar.strip.gsub(/  */, " "))
                .where("sitio ILIKE ?", sitio.strip.gsub(/  */, " "))
              if ubi.count > 0
                # modificando existente
                ubi[0].tsitio_id = tsitio_id
                ubi[0].latitud = latitud
                ubi[0].longitud = longitud
                if ubi[0].save
                  return ubi[0].id
                else
                  Rails.logger.debug { "Problema salvando ubi #{ubi[0]}" }
                  return
                end
              end
              w[:lugar] = lugar.strip.gsub(/  */, " ")
              w[:sitio] = sitio.strip.gsub(/  */, " ")
            end
            # Intentamos añadir nuevo teniendo en cuenta que lugar y sitio
            # ya estan dilig.
            w[:tsitio_id] = tsitio_id.to_i
            w[:latitud] = latitud
            w[:longitud] = longitud
            w[:nombre], w[:nombre_sin_pais] = Msip::Ubicacionpre.nomenclatura(
              opais.nombre,
              odepartamento ? odepartamento.nombre : "",
              omunicipio ? omunicipio.nombre : "",
              overeda ? overeda.nombre : "",
              ocentropoblado ? ocentropoblado.nombre : "",
              w[:lugar],
              w[:sitio],
            )
            if Msip::Ubicacionpre.where(nombre: w[:nombre]).count == 1
              Rails.logger.debug do
                "Problema, ya hay una ubicación con el nombre #{w[:nombre]}. " \
                  "Proveniente de #{w.inspect}. Se usará esa ignorando la " \
                  "informacińo recibida"
              end
              return Msip::Ubicacionpre.where(nombre: w[:nombre]).first.id
            end
            Rails.logger.debug "OJO w=#{w.inspect}"
            nubi = Msip::Ubicacionpre.create!(w)
            unless nubi
              Rails.logger.debug { "Problema creando ubi #{nubi}" }
              return
            end
            nubi.id
          end

        end # class_methods
      end
    end
  end
end
