class TriggersUbicacionpreVereda < ActiveRecord::Migration[7.1]

  def up
    execute <<-EOF
      CREATE FUNCTION public.msip_ubicacionpre_tras_crear_vereda () 
      RETURNS trigger
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
          RAISE NOTICE 'mi_departamento_id = %', mi_departamento_id;
          mi_pais_id := (SELECT pais_id FROM public.msip_departamento
            WHERE id=mi_departamento_id LIMIT 1);
          RAISE NOTICE 'mi_pais_id = %', mi_pais_id;
          nompais := (SELECT nombre FROM public.msip_pais 
            WHERE id=mi_pais_id LIMIT 1);
          RAISE NOTICE 'nompais = %', nompais;
          nomdepartamento := (SELECT nombre FROM public.msip_departamento
            WHERE id=mi_departamento_id LIMIT 1);
          RAISE NOTICE 'nomdepartamento = %', nomdepartamento;
          nommunicipio := (SELECT nombre FROM public.msip_municipio
            WHERE id=NEW.municipio_id LIMIT 1);
          RAISE NOTICE 'nommunicipio = %', nommunicipio;
          dpa := public.msip_ubicacionpre_dpa_nomenclatura(
            nompais, nomdepartamento, nommunicipio, NEW.nombre, ''
          );
          RAISE NOTICE 'dpa[0] = %', dpa[0];
          RAISE NOTICE 'dpa[1] = %', dpa[1];
          INSERT INTO public.msip_ubicacionpre (nombre, pais_id,
            departamento_id, municipio_id, centropoblado_id, vereda_id,
            lugar, sitio, tsitio_id, latitud, longitud,
            nombre_sin_pais, observaciones,
            fechacreacion, fechadeshabilitacion, created_at, updated_at)
          VALUES (dpa[1], mi_pais_id, 
            mi_departamento_id, NEW.municipio_id, NULL, NEW.id,
            NULL, NULL, NULL, NEW.latitud, NEW.longitud,
            dpa[2], NULL,
            NEW.fechacreacion, NULL, NOW(), NOW());
        END IF;
        RETURN NULL;
      END ;
      $$;

      CREATE TRIGGER msip_tras_crear_vereda
        AFTER INSERT ON msip_vereda
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_crear_vereda();


      -- Si actualizamos en cascada
      CREATE FUNCTION public.msip_ubicacionpre_tras_actualizar_vereda() RETURNS trigger
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
        RAISE NOTICE 'Actualizando vereda';
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
            AND vereda_id=NEW.id
            AND centropoblado_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL;

        -- Actualizamos lo que está dentro de la vereda en cascada (esperamos
        -- llamada al trigger de nomenclatura para arreglar nombre_sin_pais por
        -- ejemplo)
        UPDATE public.msip_ubicacionpre SET
          nombre=REPLACE(nombre, OLD.nombre, NEW.nombre),
          updated_at=NOW()
        WHERE pais_id=mi_pais_id
          AND departamento_id=mi_departamento_id
          AND municipio_id=NEW.municipio_id
          AND vereda_id=NEW.id
          AND NOT (centropoblado_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL);

        RETURN NULL;
      END ;
    $$;

    -- Cambio de departamento_id por ahora es mejor en una migración
    CREATE TRIGGER msip_tras_actualizar_vereda
        AFTER UPDATE OF nombre, latitud, longitud ON msip_vereda
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_actualizar_vereda();

    -- Pero no eliminamos en cascada --tendrá que hacerse desde la aplicación 
    -- uno a uno o con una migración
    CREATE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_vereda() 
    RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        ASSERT(TG_OP = 'DELETE');
        RAISE NOTICE 'Eliminando vereda';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'OLD.id = %', OLD.id;
        RAISE NOTICE 'OLD.nombre = %', OLD.nombre;

        DELETE FROM public.msip_ubicacionpre WHERE 
          municipio_id=OLD.municipio_id
          AND vereda_id=OLD.id
          AND centropoblado_id IS NULL
          AND lugar IS NULL;
        RETURN OLD;
      END ;
      $$;

      CREATE TRIGGER msip_antes_de_eliminar_vereda
        BEFORE DELETE ON msip_vereda
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_vereda();

    EOF
  end
  def down
    execute <<-SQL
      DROP TRIGGER msip_antes_de_eliminar_vereda ON msip_vereda;
      DROP FUNCTION public.msip_ubicacionpre_antes_de_eliminar_vereda;

      DROP TRIGGER msip_tras_actualizar_vereda ON msip_vereda;
      DROP FUNCTION public.msip_ubicacionpre_tras_actualizar_vereda;

      DROP TRIGGER msip_tras_crear_vereda ON msip_vereda;
      DROP FUNCTION public.msip_ubicacionpre_tras_crear_vereda;
    SQL
  end

end
