# frozen_string_literal: true

module Msip
  module SqlHelper
    # Pone cotejación dada a una columna tipo varchar (longitud long)
    def cambiar_cotejacion(tabla, columna, long, cotejacion)
      ActiveRecord::Base.connection.execute(<<-SQL.squish)
      ALTER TABLE #{tabla}
        ALTER COLUMN #{columna} SET DATA TYPE#{" "}
          VARCHAR(#{long.to_i}) COLLATE "#{cotejacion}";
      SQL
    end
    module_function :cambiar_cotejacion

    alias_method :cambiaCotejacion, :cambiar_cotejacion
    module_function :cambiaCotejacion

    def ejecuta_sql(sql, eco = false)
      if eco
        Rails.logger.debug { "ejecuta_sql: #{sql}" }
      end
      Msip::Persona.connection.execute(<<-SQL.squish)
      #{sql}
      SQL
    end
    module_function :ejecuta_sql

    # Cambia convención para sexo
    def cambiar_convencion_sexo(convencion_final)
      unless Msip::Persona::CONVENCIONES_SEXO.keys.include?(convencion_final)
        Rails.logger.debug { "Conveción desconocida: #{convecion_final}" }
        exit(1)
      end
      convencion_inicial = Msip::Persona.convencion_sexo_abreviada
      if convencion_inicial == convencion_final
        return
      end

      if convencion_final != "FMS" && convencion_final != "MHS"
        Rails.logger.debug { "Se espera cambio  a convencion desconocida #{convencion_final}" }
        return
      end
      ejecuta_sql(
        "ALTER TABLE msip_persona DROP CONSTRAINT persona_sexo_check",
        true,
      )

      # Orden importa por ahora soporta bien FMS -> MHS y MHS->FMS
      if convencion_inicial == "FMS" && convencion_final == "MHS"
        ejecuta_sql(
          "UPDATE msip_persona SET sexo='H'"\
            " WHERE sexo='M';",
          true,
        )
        ejecuta_sql(
          "UPDATE msip_persona SET sexo='M'"\
            " WHERE sexo='F';",
          true,
        )
        ejecuta_sql(
          "UPDATE msip_persona SET sexo='S'"\
            " WHERE sexo='S';",
          true,
        )
      elsif convencion_inicial == "MHS" && convencion_final == "FMS"
        ejecuta_sql(
          "UPDATE msip_persona SET sexo='F'"\
            " WHERE sexo='M';",
          true,
        )
        ejecuta_sql(
          "UPDATE msip_persona SET sexo='M'"\
            " WHERE sexo='H';",
          true,
        )
        ejecuta_sql(
          "UPDATE msip_persona SET sexo='S'"\
            " WHERE sexo='S';",
          true,
        )
      end

      ejecuta_sql(
        "ALTER TABLE msip_persona ADD CONSTRAINT persona_sexo_check "\
          " CHECK (LENGTH(sexo)=1 "\
          " AND '#{convencion_final}' LIKE '%' || sexo || '%');",
        true,
      )
    end
    module_function :cambiar_convencion_sexo

    ##
    # Agrega una nueva tabla al listado $t
    #
    # @param t [Array<String>] Listado de tablas separadas por ,
    # @param nt [String] Nueva tabla por agregar si falta
    #
    # @return [String] cadena t completada para asegurar tabla
    # /
    def agregar_tabla(t, nt)
      at = t.split(",").map(&:strip)
      unless at.include?(nt.strip)
        at << nt
      end
      t = at.join(",")
    end
    module_function :agregar_tabla

    alias_method :agrega_tabla, :agregar_tabla
    module_function :agrega_tabla

    ##
    # Agrega condición a WHERE en un SELECT de SQL
    #
    # @param [Object]  db   Conexión a base de datos
    # @param [String]  w    cadena con WHERE que se completa
    # @param [String]  n     nombre de campo
    # @param [String]  v     valor esperado
    # @param [String]  opcmp operador de comparación por usar.
    # @param [String]  con   con
    #
    # @return string cadena w completada con nueva condición
    def ampliar_where(w, n, v, opcmp = "=", con = "AND")
      if !v || v === "" || $v === " "
        return
      end

      if w != ""
        w += " #{con}"
      end
      w += " " + n + opcmp + Sivel2Gen::Caso.connection.quote(v)
    end
    module_function :ampliar_where
    alias_method :consulta_and, :ampliar_where
    module_function :consulta_and

    ##
    # Como la función anterior sólo que el valor no lo pone entre
    # apostrofes y supone que ya viene escapado el valor $v
    #
    # @param w [String]     cadena con WHERE que se completa
    # @param n [String]     nombre de campo
    # @param v [String]     valor esperado
    # @param opcmp [String] operador de comparación por usar.
    # @param con [String]   conector
    #
    # @return [String] cadena w completada con nueva condición
    # /
    def ampliar_where_sinap(w, n, v, opcmp = "=", con = "AND")
      if w != ""
        w += " " + con
      end
      w += " " + n + opcmp + v
    end
    module_function :ampliar_where_sinap

    alias_method :consulta_and_sinap, :ampliar_where_sinap
    module_function :consulta_and_sinap

    # Escapa la cadena c para usarla en consulta SQL
    def escapar(c)
      Sivel2Gen::Caso.connection.quote_string(c)
    end
    module_function :escapar

    alias_method :cadena_escapa, :escapar
    module_function :cadena_escapa

    # Escapa el parámetro p (supone que es usable la variable global params)
    def escapar_param(params, p, poromision = "")
      if p.is_a?(String) || p.is_a?(Symbol)
        params[p] ? escapar(params[p]) : ""
      elsif p.is_a?(Array) && p.length == 1
        params[p[0]] ? espacar_cadena(params[p[0]]) : ""
      elsif p.is_a?(Array) && p.length > 1 && params[p[0]]
        n = params[p[0]]
        i = 1
        while i < (p.length - 2)
          if n[p[i]]
            n = n[p[i]]
          else
            return ""
          end
          i += 1
        end
        if n[p[i]]
          escapar(n[p[i]])
        else
          poromision
        end
      else
        poromision
      end
    end
    module_function :escapar_param

    alias_method :param_escapa, :escapar_param
    module_function :param_escapa

    # Vuelve a habilitar un centro poblado
    # e.g MORALES desapareció de DIVIPOLA 2018 y volvió a aprecer en
    # DIVIPOLA 2020
    def rehabilita_centropoblado(
      id, municipio_id, cplocal_cod, nombre, observacion, fechacreacion
    )

      # byebug
      if Msip::Centropoblado.where(id: id).count > 0
        c = Msip::Centropoblado.find(id)
        if c.municipio_id != municipio_id || c.cplocal_cod != cplocal_cod ||
            c.nombre != nombre
          Rails.logger.debug do
            "Se espera que centro poblado #{id} fuera #{nombre} "\
              " en municipio #{municipio_id} con cplocal_cod #{cplocal_cod}"
          end
          exit(1)
        end
        c.fechadeshabilitacion = nil
        c.observaciones << ((c.observaciones.to_s == "" ? "" : ". ") + observacion)
        c.save!
      else
        c = Msip::Centropoblado.new(
          id: id,
          municipio_id: municipio_id,
          cplocal_cod: cplocal_cod,
          nombre: nombre,
          observaciones: observacion,
          fechacreacion: fechacreacion,
          created_at: fechacreacion,
          updated_at: fechacreacion,
        )
      end
    end
    module_function :rehabilita_centropoblado

    # Decide si existe una función f en base PostgreSQL
    def existe_función_pg?(f)
      c = "SELECT EXISTS("\
        "SELECT * FROM pg_proc "\
        "WHERE proname = #{ActiveRecord::Base.connection.quote(f)}"\
        ");"
      r = ActiveRecord::Base.connection.execute(c)
      r[0]["exists"]
    end
    module_function :existe_función_pg?

    # Decide si existe un índice i en base PostgreSQL
    # https://stackoverflow.com/questions/45983169/checking-for-existence-of-index-in-postgresql
    def existe_índice_pg?(f)
      r = ActiveRecord::Base.connection.execute(<<~SQL.squish)
        SELECT  EXISTS (SELECT i.relname AS index_name
          FROM pg_class i, pg_index ix
          WHERE i.oid = ix.indexrelid
            AND i.relname = #{ActiveRecord::Base.connection.quote(f)}
        );
      SQL
      r[0]["exists"]
    end
    module_function :existe_índice_pg?

    # Decide si existe una restricción r en base PostgreSQL
    def existe_restricción_pg?(r)
      c = "SELECT EXISTS("\
        "SELECT * FROM pg_constraint "\
        "WHERE conname = #{ActiveRecord::Base.connection.quote(r)}"\
        ");"
      r = ActiveRecord::Base.connection.execute(c)
      r[0]["exists"]
    end
    module_function :existe_restricción_pg?

    # Decide si existe una restricción r en una tabla t en una base PostgreSQL
    def existe_restricción_en_tabla_pg?(r, t)
      c = "SELECT EXISTS("\
        "SELECT * FROM pg_constraint "\
        "WHERE conname = #{ActiveRecord::Base.connection.quote(r)}"\
        "  AND conrelid=(SELECT oid FROM pg_class "\
        "    WHERE relname = #{ActiveRecord::Base.connection.quote(t)})"\
        ");"
      r = ActiveRecord::Base.connection.execute(c)
      r[0]["exists"]
    end
    module_function :existe_restricción_en_tabla_pg?

    # Decide si existe una secuencia s en base PostgreSQL
    def existe_secuencia_pg?(s)
      reversible do |_dir|
        c = "SELECT EXISTS("\
          "SELECT * FROM pg_class c WHERE c.relkind = 'S' "\
          "AND c.relname = #{ActiveRecord::Base.connection.quote(s)}"\
          ");"
        r = ActiveRecord::Base.connection.execute(c)
        r[0]["exists"]
      end
    end
    module_function :existe_secuencia_pg?

    # Renombra una función en base PostgreSQL
    # @param nomini Nombre inicial
    # @param nomfin Nombre final
    def renombrar_función_pg(nomini, nomfin)
      reversible do |dir|
        dir.up   do
          ActiveRecord::Base.connection.execute(
            "ALTER FUNCTION #{nomini} RENAME TO #{nomfin};",
          )
        end
        dir.down do
          ActiveRecord::Base.connection.execute(
            "ALTER FUNCTION #{nomfin} RENAME TO #{nomini};",
          )
        end
      end
    end
    module_function :renombrar_función_pg

    # Renombra un índice en base PostgreSQL
    # @param nomini Nombre inicial
    # @param nomfin Nombre final
    def renombrar_índice_pg(nomini, nomfin)
      reversible do |dir|
        dir.up   do
          ActiveRecord::Base.connection.execute(
            "ALTER INDEX #{nomini} RENAME TO #{nomfin};",
          )
        end
        dir.down do
          ActiveRecord::Base.connection.execute(
            "ALTER INDEX #{nomfin} RENAME TO #{nomini};",
          )
        end
      end
    end
    module_function :renombrar_índice_pg

    # Renombra una restricción en base PostgreSQL
    # @param tabla Tabla con la restricción
    # @param nomini Nombre inicial de restricción
    # @param nomfin Nombre final
    def renombrar_restricción_pg(tabla, nomini, nomfin)
      reversible do |dir|
        dir.up   do
          ActiveRecord::Base.connection.execute("ALTER TABLE #{tabla} "\
            "RENAME CONSTRAINT #{nomini} TO #{nomfin};")
        end
        dir.down do
          ActiveRecord::Base.connection.execute("ALTER TABLE #{tabla} "\
            "RENAME CONSTRAINT #{nomfin} TO #{nomini};")
        end
      end
    end
    module_function :renombrar_restricción_pg

    # Renombra una secuencia en base PostgreSQL
    # @param nomini Nombre inicial
    # @param nomfin Nombre final
    def renombrar_secuencia_pg(nomini, nomfin)
      reversible do |dir|
        dir.up   do
          ActiveRecord::Base.connection.execute(
            "ALTER SEQUENCE #{nomini} RENAME TO #{nomfin};",
          )
        end
        dir.down do
          ActiveRecord::Base.connection.execute(
            "ALTER SEQUENCE #{nomfin} RENAME TO #{nomini};",
          )
        end
      end
    end
    module_function :renombrar_secuencia_pg

    # Renombra una vista en base PostgreSQL
    # @param nomini Nombre inicial
    # @param nomfin Nombre final
    def renombrar_vista_pg(nomini, nomfin)
      reversible do |dir|
        dir.up   do
          ActiveRecord::Base.connection.execute(
            "ALTER VIEW #{nomini} RENAME TO #{nomfin};",
          )
        end
        dir.down do
          ActiveRecord::Base.connection.execute(
            "ALTER VIEW #{nomfin} RENAME TO #{nomini};",
          )
        end
      end
    end
    module_function :renombrar_vista_pg

    # Renombra una vista materializada en base PostgreSQL
    # @param nomini Nombre inicial
    # @param nomfin Nombre final
    def renombrar_vistamat_pg(nomini, nomfin)
      reversible do |dir|
        dir.up   do
          ActiveRecord::Base.connection.execute(
            "ALTER MATERIALIZED VIEW #{nomini} RENAME TO #{nomfin};",
          )
        end
        dir.down do
          ActiveRecord::Base.connection.execute(
            "ALTER MATERIALIZED VIEW #{nomfin} RENAME TO #{nomini};",
          )
        end
      end
    end
    module_function :renombrar_vistamat_pg
  end
end
