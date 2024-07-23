class TriggersUbicacionpreCp< ActiveRecord::Migration[7.1]

  def up
    execute <<-EOF

      CREATE FUNCTION public.msip_ubicacionpre_tras_crear_centropoblado () RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      DECLARE
        dpa TEXT[];
        mi_pais_id INTEGER;
        mi_departamento_id INTEGER;
        nompais TEXT;
        nomdepartamento TEXT;
        nommunicipio TEXT;
      BEGIN
        ASSERT(TG_OP = 'INSERT');
        -- Los comunes se insertan manualmente con ids. diseñadas
        IF NEW.id > 1000000 THEN
          RAISE NOTICE 'Insertando centro poblado propio';
          RAISE NOTICE 'TG_OP = %', TG_OP;
          RAISE NOTICE 'NEW.id = %', NEW.id;
          RAISE NOTICE 'NEW.municipio_id = %', NEW.municipio_id;
          RAISE NOTICE 'NEW.nombre = %', NEW.nombre;
          RAISE NOTICE 'NEW.latitud = %', NEW.latitud;
          RAISE NOTICE 'NEW.longitud = %', NEW.longitud;
          RAISE NOTICE 'NEW.observaciones = %', NEW.observaciones;

          mi_departamento_id := (SELECT departamento_id 
            FROM public.msip_municipio
            WHERE id=NEW.municipio_id LIMIT 1);
          mi_pais_id := (SELECT pais_id FROM public.msip_departamento
            WHERE id=mi_departamento_id LIMIT 1);
          nompais := (SELECT nombre FROM public.msip_pais 
            WHERE id=mi_pais_id LIMIT 1);
          nomdepartamento := (SELECT nombre FROM public.msip_departamento
            WHERE id=mi_departamento_id LIMIT 1);
          nommunicipio := (SELECT nombre FROM public.msip_municipio
            WHERE id=NEW.municipio_id LIMIT 1);
          dpa := public.msip_ubicacionpre_dpa_nomenclatura(
            nompais, nomdepartamento, nommunicipio, NEW.nombre, ''
          );
          INSERT INTO public.msip_ubicacionpre (nombre, pais_id,
            departamento_id, municipio_id, centropoblado_id, vereda_id,
            lugar, sitio, tsitio_id, latitud, longitud,
            nombre_sin_pais, observaciones,
            fechacreacion, fechadeshabilitacion, created_at, updated_at)
          VALUES (dpa[1], mi_pais_id, 
            mi_departamento_id, NEW.municipio_id, NEW.id, NULL,
            NULL, NULL, NULL, NEW.latitud, NEW.longitud,
            dpa[2], NULL,
            NEW.fechacreacion, NULL, NOW(), NOW());
        END IF;
        RETURN NULL;
      END ;
      $$;

      CREATE TRIGGER msip_tras_crear_centropoblado
        AFTER INSERT ON msip_centropoblado
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_crear_centropoblado();


      -- Si actualizamos en cascada
      CREATE FUNCTION public.msip_ubicacionpre_tras_actualizar_centropoblado() RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      DECLARE
        dpa TEXT[];
        mi_pais_id INTEGER;
        mi_departamento_id INTEGER;
        nompais TEXT;
        nomdepartamento TEXT;
        nommunicipio TEXT;
      BEGIN
        ASSERT(TG_OP = 'UPDATE');
        RAISE NOTICE 'Actualizando centropoblado';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'NEW.id = %', NEW.id;
        RAISE NOTICE 'NEW.nombre = %', NEW.nombre;
        RAISE NOTICE 'NEW.latitud = %', NEW.latitud;
        RAISE NOTICE 'NEW.longitud = %', NEW.longitud;
        RAISE NOTICE 'NEW.observaciones = %', NEW.observaciones;

        mi_departamento_id := (SELECT departamento_id 
          FROM public.msip_municipio
          WHERE id=NEW.municipio_id LIMIT 1);
        mi_pais_id := (SELECT pais_id FROM public.msip_departamento
          WHERE id=mi_departamento_id LIMIT 1);
        nompais := (SELECT nombre FROM public.msip_pais 
          WHERE id=mi_pais_id LIMIT 1);
        nomdepartamento := (SELECT nombre FROM public.msip_departamento
          WHERE id=mi_departamento_id LIMIT 1);
        nommunicipio := (SELECT nombre FROM public.msip_municipio
          WHERE id=NEW.municipio_id LIMIT 1);

        dpa := public.msip_ubicacionpre_dpa_nomenclatura(
          nompais, nomdepartamento, nommunicipio, '', NEW.nombre
        );

        UPDATE public.msip_ubicacionpre SET
          nombre=dpa[1],
          nombre_sin_pais=dpa[2],
          latitud=NEW.latitud,
          longitud=NEW.longitud,
          updated_at=NOW()
        WHERE pais_id=mi_pais_id
            AND departamento_id=mi_departamento_id
            AND municipio_id=NEW.municipio_id
            AND centropoblado_id=NEW.id
            AND vereda_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL;

        -- Actualizamos lo que está dentro del centropoblado en cascada (esperamos
        -- llamada al trigger de nomenclatura para arreglar nombre_sin_pais por
        -- ejemplo)
        UPDATE public.msip_ubicacionpre SET
          nombre=REPLACE(nombre, OLD.nombre, NEW.nombre),
          updated_at=NOW()
        WHERE pais_id=mi_pais_id
          AND departamento_id=mi_departamento_id
          AND municipio_id=NEW.municipio_id
          AND centropoblado_id=NEW.id
          AND NOT (vereda_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL);

        RETURN NULL;
      END ;
    $$;

    -- Cambio de departamento_id por ahora es mejor en una migración
    CREATE TRIGGER msip_tras_actualizar_centropoblado
        AFTER UPDATE OF nombre, latitud, longitud ON msip_centropoblado
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_actualizar_centropoblado();

    -- Pero no eliminamos en cascada --tendrá que hacerse desde la aplicación 
    -- uno a uno o con una migración
    CREATE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_centropoblado() 
    RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        ASSERT(TG_OP = 'DELETE');
        RAISE NOTICE 'Eliminando centropoblado';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'OLD.id = %', OLD.id;
        RAISE NOTICE 'OLD.nombre = %', OLD.nombre;

        DELETE FROM public.msip_ubicacionpre WHERE 
          municipio_id=OLD.municipio_id
          AND centropoblado_id=OLD.id
          AND vereda_id IS NULL
          AND lugar IS NULL;
        RETURN OLD;
      END ;
      $$;

      CREATE TRIGGER msip_antes_de_eliminar_centropoblado
        BEFORE DELETE ON msip_centropoblado
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_centropoblado();

    EOF
  end
  def down
    execute <<-SQL
      DROP TRIGGER msip_antes_de_eliminar_centropoblado ON msip_centropoblado;
      DROP FUNCTION public.msip_ubicacionpre_antes_de_eliminar_centropoblado;

      DROP TRIGGER msip_tras_actualizar_centropoblado ON msip_centropoblado;
      DROP FUNCTION public.msip_ubicacionpre_tras_actualizar_centropoblado;

      DROP TRIGGER msip_tras_crear_centropoblado ON msip_centropoblado;
      DROP FUNCTION public.msip_ubicacionpre_tras_crear_centropoblado;
    SQL
  end

end
