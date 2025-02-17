# frozen_string_literal: true

module Msip
  module Concerns
    module Controllers
      module UbicacionespreController
        extend ActiveSupport::Concern

        included do
          def clase
            "Msip::Ubicacionpre"
          end

          def genclase
            "F"
          end

          def atributos_index
            [
              :id,
              :nombre,
              :nombre_sin_pais,
              :pais,
              :departamento,
              :municipio,
              :centropoblado,
              :vereda,
              :lugar,
              :sitio,
              :tsitio,
              :latitud,
              :longitud,
              :observaciones,
              :fechacreacion,
              :fechadeshabilitacion,
            ]
          end

          def atributos_show
            atributos_index
          end

          def atributos_form
            a = atributos_show - [:id, :nombre, :nombre_sin_pais]
            a
          end

          def mundep
            if params[:term]
              term = Msip::Ubicacion.connection.quote_string(params[:term])
              consNomubi = term.downcase.strip # sin_tildes
              consNomubi.gsub!(/ +/, ":* & ")
              unless consNomubi.empty?
                consNomubi += ":*"
              end
              # Usamos la funcion f_unaccent definida con el indice
              # en db/migrate/20200916022934_indice_ubicacionpre.rb
              where = " to_tsvector('spanish', " \
                "f_unaccent(ubicacionpre.nombre_sin_pais)) " \
                "@@ to_tsquery('spanish', '#{consNomubi}')"

              cons = "SELECT TRIM(nombre_sin_pais) AS value, id AS id " \
                "FROM public.msip_ubicacionpre AS ubicacionpre " \
                "WHERE #{where} AND pais_id=170 " \
                "AND centropoblado_id IS NULL " \
                "AND vereda_id IS NULL " \
                "AND departamento_id IS NOT NULL " \
                "AND lugar IS NULL " \
                "AND sitio IS NULL  " \
                "ORDER BY 1 LIMIT 10"

              r = ActiveRecord::Base.connection.select_all(cons)
              respond_to do |format|
                format.json { render(:json, inline: r.to_json) }
                format.html { render(inline: "No responde con parametro term") }
              end
            end
          end

          def index(c = nil)
            if c.nil?
              c = Msip::Ubicacionpre.all
            end
            if params[:term]
              term = Msip::Ubicacionpre.connection.quote_string(params[:term])
              consNomubi = term.downcase.strip # sin_tildes
              consNomubi.gsub!(/ +/, ":* & ")
              unless consNomubi.empty?
                consNomubi += ":*"
              end
              # Usamos la funcion f_unaccent definida con el indice
              # en db/migrate/20200916022934_indice_ubicacionpre.rb
              where = " to_tsvector('spanish', f_unaccent(ubicacionpre.nombre)) " \
                "@@ to_tsquery('spanish', '#{consNomubi}')"

              cons = "SELECT TRIM(nombre) AS value, id AS id " \
                "FROM public.msip_ubicacionpre AS ubicacionpre " \
                "WHERE #{where} ORDER BY 1 LIMIT 10"

              r = ActiveRecord::Base.connection.select_all(cons)
              respond_to do |format|
                format.json { render(:json, inline: r.to_json) }
                format.html { render(inline: "No responde con parametro term") }
              end
            else
              super
            end
          end

          def filtra_contenido_params
            if !params || !params[:ubicacionpre] ||
                !params[:ubicacionpre][:lugar] ||
                !params[:ubicacionpre][:lugar].strip == "" ||
                !params[:ubicacionpre][:pais_id] ||
                Msip::Pais.where(id: params[:ubicacionpre][:pais_id]).count != 1
              return
            end

            pais = Msip::Pais.find(params[:ubicacionpre][:pais_id])
            departamento = Msip::Departamento
              .find_by(id: params[:ubicacionpre][:departamento_id])
            municipio = Msip::Municipio
              .find_by(id: params[:ubicacionpre][:municipio_id])
            centropoblado = Msip::Centropoblado
              .find_by(id: params[:ubicacionpre][:centropoblado_id])
            vereda = Msip::Vereda
              .find_by(id: params[:ubicacionpre][:vereda_id])

            n = Msip::Ubicacionpre.nomenclatura(
              pais.nombre,
              departamento ? departamento.nombre : "",
              municipio ? municipio.nombre : "",
              centropoblado ? centropoblado.nombre : "",
              vereda ? vereda.nombre : "",
              params[:ubicacionpre][:lugar],
              params[:ubicacionpre][:sitio],
            )
            params[:ubicacionpre][:nombre] = n[0]
            params[:ubicacionpre][:nombre_sin_pais] = n[1]
          end

          def validar_conjunto_paises_biyeccion(validaciones)
            if Msip::Pais.all.count != Msip::Ubicacionpre.where(lugar: nil)
                .where(departamento_id: nil).count
              validaciones << {
                titulo: "Diferencia en paises y ubicacionespre dpa de paises",
                encabezado: ["Tabla País", "Ubicacionespre dpa pais"],
                cuerpo: [
                  [
                    Msip::Pais.all.count,
                    Msip::Ubicacionpre.where(lugar: nil).where(
                      departamento_id: nil,
                    ).count,
                  ],
                ],
                enlaces: nil,
              }
            end

            ps = Msip::Pais.where(
              "id NOT IN (SELECT pais_id FROM msip_ubicacionpre   " \
                "WHERE lugar IS NULL   " \
                "AND departamento_id IS NULL)",
            )
            if ps.count > 0
              validaciones << {
                titulo: "Países que no tienen ubicacionpre dpa",
                encabezado: ["Código", "Nombre"],
                cuerpo: ps.pluck(:id, :nombre),
                enlaces: nil,
              }
            end

            ps = ActiveRecord::Base.connection.execute(<<-SQL)
              SELECT id, nombre, cuenta,
                 ARRAY(SELECT id FROM msip_ubicacionpre
                   WHERE lugar IS NULL#{" "}
                   AND departamento_id IS NULL
                   AND pais_id=s.id) AS ubids FROM
                (SELECT id, nombre, (SELECT count(*) FROM msip_ubicacionpre
                WHERE lugar IS NULL#{" "}
                AND departamento_id IS NULL
                AND pais_id=msip_pais.id) AS cuenta FROM msip_pais) AS s
                WHERE s.cuenta > 1;
            SQL
            if ps.count > 0
              validaciones << {
                titulo: "Países con más de una ubicacionpre dpa",
                encabezado: [
                  "Código",
                  "Nombre",
                  "Veces como ubicacionpre dpa",
                  "Códigos",
                ],
                cuerpo: ps.pluck("id", "nombre", "cuenta", "ubids"),
                enlaces: nil,
              }
            end
          end

          def validar_conjunto_departamentos_biyeccion(validaciones)
            if Msip::Departamento.all.count != Msip::Ubicacionpre
                .where(lugar: nil).where.not(departamento_id: nil)
                .where(municipio_id: nil).count
              validaciones << {
                titulo: "Diferencia en deptos y ubicacionespre dpa de deptos",
                encabezado: [
                  "Tabla Departamento",
                  "Ubicacionespre dpa departamento",
                ],
                cuerpo: [
                  [
                    Msip::Departamento.all.count,
                    Msip::Ubicacionpre.where(lugar: nil).where.not(
                      departamento_id: nil,
                    ).where(
                      municipio_id: nil,
                    ).count,
                  ],
                ],
                enlaces: nil,
              }
            end

            ps = Msip::Departamento.where(
              "id NOT IN (SELECT departamento_id FROM msip_ubicacionpre   " \
                "WHERE lugar IS NULL " \
                "AND departamento_id IS NOT NULL " \
                "AND municipio_id IS NULL)",
            )
            if ps.count > 0
              validaciones << {
                titulo: "Departamentos que no tienen ubicacionpre dpa",
                encabezado: ["Código", "Nombre"],
                cuerpo: ps.pluck(:id, :nombre),
                enlaces: nil,
              }
            end

            ps = ActiveRecord::Base.connection.execute(<<-SQL)
              SELECT id, nombre, cuenta,
                 ARRAY(SELECT id FROM msip_ubicacionpre
                   WHERE lugar IS NULL#{" "}
                   AND municipio_id IS NULL
                   AND departamento_id=s.id) AS ubids FROM
                (SELECT id, nombre, (SELECT count(*) FROM msip_ubicacionpre
                WHERE lugar IS NULL
                AND municipio_id IS NULL
                AND departamento_id=msip_departamento.id) AS cuenta
              FROM msip_departamento) AS s
              WHERE s.cuenta > 1;
            SQL
            if ps.count > 0
              validaciones << {
                titulo: "Departamentos con más de una ubicacionpre dpa",
                encabezado: [
                  "Código",
                  "Nombre",
                  "Veces como ubicacionpre dpa",
                  "Códigos",
                ],
                cuerpo: ps.pluck("id", "nombre", "cuenta", "ubids"),
                enlaces: nil,
              }
            end
          end

          def validar_conjunto_municipios_biyeccion(validaciones)
            if Msip::Municipio.all.count != Msip::Ubicacionpre
                .where(lugar: nil).where.not(municipio_id: nil)
                .where(centropoblado_id: nil).where(vereda_id: nil).count
              validaciones << {
                titulo: "Diferencia en municipios y ubicacionespre dpa de estos",
                encabezado: [
                  "Tabla Municipio",
                  "Ubicacionespre dpa municipio",
                ],
                cuerpo: [
                  [
                    Msip::Municipio.all.count,
                    Msip::Ubicacionpre.where(lugar: nil).where.not(
                      municipio_id: nil,
                    ).where(
                      centropoblado_id: nil,
                    ).where(
                      vereda_id: nil,
                    ).count,
                  ],
                ],
                enlaces: nil,
              }
            end

            ps = Msip::Municipio.where(
              "id NOT IN (SELECT municipio_id FROM msip_ubicacionpre   " \
                "WHERE lugar IS NULL   " \
                "AND municipio_id IS NOT NULL   " \
                "AND centropoblado_id IS NULL  " \
                "AND vereda_id IS NULL)",
            )
            if ps.count > 0
              validaciones << {
                titulo: "Municipios que no tienen ubicacionpre dpa",
                encabezado: ["Código", "Nombre"],
                cuerpo: ps.pluck(:id, :nombre),
                enlaces: nil,
              }
            end

            ps = ActiveRecord::Base.connection.execute(<<-SQL)
              SELECT id, nombre, cuenta,
                 ARRAY(SELECT id FROM msip_ubicacionpre
                   WHERE lugar IS NULL#{" "}
                   AND centropoblado_id IS NULL
                   AND vereda_id IS NULL
                   AND municipio_id=s.id) AS ubids FROM
                (SELECT id, nombre, (SELECT count(*) FROM msip_ubicacionpre
                WHERE lugar IS NULL
                AND centropoblado_id IS NULL
                AND vereda_id IS NULL
                AND municipio_id=msip_municipio.id) AS cuenta
              FROM msip_municipio) AS s
              WHERE s.cuenta > 1;
            SQL
            if ps.count > 0
              validaciones << {
                titulo: "Municipios con más de una ubicacionpre dpa",
                encabezado: [
                  "Código",
                  "Nombre",
                  "Veces como ubicacionpre dpa",
                  "Códigos",
                ],
                cuerpo: ps.pluck("id", "nombre", "cuenta", "ubids"),
                enlaces: nil,
              }
            end
          end

          def validar_conjunto_centrospoblados_biyeccion(validaciones)
            if Msip::Centropoblado.all.count != Msip::Ubicacionpre
                .where(lugar: nil).where.not(centropoblado_id: nil)
                .where(vereda_id: nil).count
              validaciones << {
                titulo: "Diferencia en centros poblados y ubicacionespre dpa de estos",
                encabezado: [
                  "Tabla Centropoblado",
                  "Ubicacionespre dpa centropoblado",
                ],
                cuerpo: [
                  [
                    Msip::Centropoblado.all.count,
                    Msip::Ubicacionpre.where(lugar: nil).where.not(
                      centropoblado_id: nil,
                    ).where(
                      vereda_id: nil,
                    ).count,
                  ],
                ],
                enlaces: nil,
              }
            end

            ps = Msip::Centropoblado.where(
              "id NOT IN (SELECT centropoblado_id FROM msip_ubicacionpre   " \
                "WHERE lugar IS NULL   " \
                "AND centropoblado_id IS NOT NULL  " \
                "AND vereda_id IS NULL)",
            )
            if ps.count > 0
              validaciones << {
                titulo: "Centros poblados que no tienen ubicacionpre dpa",
                encabezado: ["Código", "Nombre"],
                cuerpo: ps.pluck(:id, :nombre),
                enlaces: nil,
              }
            end

            ps = ActiveRecord::Base.connection.execute(<<-SQL)
              SELECT id, nombre, cuenta,
                 ARRAY(SELECT id FROM msip_ubicacionpre
                   WHERE lugar IS NULL#{" "}
                   AND vereda_id IS NULL
                   AND centropoblado_id=s.id) AS ubids FROM
                (SELECT id, nombre, (SELECT count(*) FROM msip_ubicacionpre
                WHERE lugar IS NULL
                AND vereda_id IS NULL
                AND centropoblado_id=msip_centropoblado.id) AS cuenta
              FROM msip_centropoblado) AS s
              WHERE s.cuenta > 1;
            SQL
            if ps.count > 0
              validaciones << {
                titulo: "Centros poblados con más de una ubicacionpre dpa",
                encabezado: [
                  "Código",
                  "Nombre",
                  "Veces como ubicacionpre dpa",
                  "Códigos",
                ],
                cuerpo: ps.pluck("id", "nombre", "cuenta", "ubids"),
                enlaces: nil,
              }
            end
          end

          def validar_conjunto_veredas_biyeccion(validaciones)
            if Msip::Vereda.all.count != Msip::Ubicacionpre
                .where(lugar: nil).where.not(vereda_id: nil)
                .where(centropoblado_id: nil).count
              validaciones << {
                titulo: "Diferencia en veredas y ubicacionespre dpa de estas",
                encabezado: [
                  "Tabla Vereda",
                  "Ubicacionespre dpa vereda",
                ],
                cuerpo: [
                  [
                    Msip::Vereda.all.count,
                    Msip::Ubicacionpre.where(lugar: nil).where.not(
                      vereda_id: nil,
                    ).where(
                      centropoblado_id: nil,
                    ).count,
                  ],
                ],
                enlaces: nil,
              }
            end

            ps = Msip::Vereda.where(
              "id NOT IN (SELECT vereda_id FROM msip_ubicacionpre   " \
                "WHERE lugar IS NULL   " \
                "AND vereda_id IS NOT NULL  " \
                "AND centropoblado_id IS NULL)",
            )
            if ps.count > 0
              validaciones << {
                titulo: "Veredas que no tienen ubicacionpre dpa",
                encabezado: ["Código", "Nombre"],
                cuerpo: ps.pluck(:id, :nombre),
                enlaces: nil,
              }
            end

            ps = ActiveRecord::Base.connection.execute(<<-SQL)
              SELECT id, nombre, cuenta,
                 ARRAY(SELECT id FROM msip_ubicacionpre
                   WHERE lugar IS NULL#{" "}
                   AND centropoblado_id IS NULL
                   AND vereda_id=s.id) AS ubids FROM
                (SELECT id, nombre, (SELECT count(*) FROM msip_ubicacionpre
                WHERE lugar IS NULL
                AND centropoblado_id IS NULL
                AND vereda_id=msip_vereda.id) AS cuenta
              FROM msip_vereda) AS s
              WHERE s.cuenta > 1;
            SQL
            if ps.count > 0
              validaciones << {
                titulo: "Veredas con más de una ubicacionpre dpa",
                encabezado: [
                  "Código",
                  "Nombre",
                  "Veces como ubicacionpre dpa",
                  "Códigos",
                ],
                cuerpo: ps.pluck("id", "nombre", "cuenta", "ubids"),
                enlaces: nil,
              }
            end
          end

          def lista_validaciones_conjunto
            [
              :validar_conjunto_paises_biyeccion,
              :validar_conjunto_departamentos_biyeccion,
              :validar_conjunto_municipios_biyeccion,
              :validar_conjunto_centrospoblados_biyeccion,
              :validar_conjunto_veredas_biyeccion,
            ]
          end

          def set_ubicacionpre
            @ubicacionpre = @registro = nil
            if params && params[:id] &&
                Msip::Ubicacionpre.where(id: params[:id]).count == 1
              @ubicacionpre = Msip::Ubicacionpre.find(params[:id])
              @registro = @ubicacionpre
            end
          end

          def lista_params
            atributos_form - [
              :pais,
              :departamento,
              :municipio,
              :centropoblado,
              :vereda,
              :tsitio,
            ] + [
              :nombre, # Será modificado por este controlador
              :nombre_sin_pais, # Será modificado por este controlador
              :pais_id,
              :departamento_id,
              :municipio_id,
              :centropoblado_id,
              :vereda_id,
              :tsitio_id,
            ]
          end

          def ubicacionpre_params
            params.require(:ubicacionpre).permit(
              lista_params,
            )
          end
        end
      end
    end
  end
end
