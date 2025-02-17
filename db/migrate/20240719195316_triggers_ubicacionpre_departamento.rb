# frozen_string_literal: true

class TriggersUbicacionpreDepartamento < ActiveRecord::Migration[7.1]
  def up
    execute(<<-EOF)

      CREATE FUNCTION public.msip_ubicacionpre_tras_crear_departamento () RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      DECLARE
        dpa TEXT[];
        nompais TEXT;
      BEGIN
        ASSERT(TG_OP = 'INSERT');
        -- Los comunes se insertan manualmente con ids. diseñadas
        IF NEW.id > 10000 THEN
          RAISE NOTICE 'Insertando departamento propio';
          RAISE NOTICE 'TG_OP = %', TG_OP;
          RAISE NOTICE 'NEW.id = %', NEW.id;
          RAISE NOTICE 'NEW.pais_id = %', NEW.pais_id;
          RAISE NOTICE 'NEW.nombre = %', NEW.nombre;
          RAISE NOTICE 'NEW.latitud = %', NEW.latitud;
          RAISE NOTICE 'NEW.longitud = %', NEW.longitud;
          RAISE NOTICE 'NEW.observaciones = %', NEW.observaciones;

          nompais := COALESCE((SELECT nombre FROM public.msip_pais WHERE id=new.pais_id LIMIT 1), '');
          dpa := public.msip_ubicacionpre_dpa_nomenclatura(
           nompais, NEW.nombre, '', '', ''
          );
          INSERT INTO public.msip_ubicacionpre (nombre, pais_id,
            departamento_id, municipio_id, centropoblado_id, vereda_id,
            lugar, sitio, tsitio_id, latitud, longitud,
            nombre_sin_pais, observaciones,
            fechacreacion, fechadeshabilitacion, created_at, updated_at)
          VALUES (dpa[1], NEW.pais_id, NEW.id,
            NULL, NULL, NULL,
            NULL, NULL, NULL, NEW.latitud, NEW.longitud,
            dpa[2], NULL,
            NEW.fechacreacion, NULL, NOW(), NOW());
        END IF;
        RETURN NULL;
      END ;
      $$;

      CREATE TRIGGER msip_tras_crear_departamento
        AFTER INSERT ON msip_departamento
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_crear_departamento();


      -- Si actualizamos en cascada
      CREATE FUNCTION public.msip_ubicacionpre_tras_actualizar_departamento() RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      DECLARE#{" "}
        dpa TEXT[];
        nompais TEXT;
      BEGIN
        ASSERT(TG_OP = 'UPDATE');
        RAISE NOTICE 'Actualizando departamento';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'NEW.id = %', NEW.id;
        RAISE NOTICE 'NEW.nombre = %', NEW.nombre;
        RAISE NOTICE 'NEW.latitud = %', NEW.latitud;
        RAISE NOTICE 'NEW.longitud = %', NEW.longitud;
        RAISE NOTICE 'NEW.observaciones = %', NEW.observaciones;

        nompais := COALESCE((SELECT nombre FROM public.msip_pais WHERE id=new.pais_id LIMIT 1), '');
        dpa := public.msip_ubicacionpre_dpa_nomenclatura(
         nompais, NEW.nombre, '', '', ''
        );
        UPDATE public.msip_ubicacionpre SET
          nombre=dpa[1],
          nombre_sin_pais=dpa[2],
          latitud=NEW.latitud,
          longitud=NEW.longitud,
          updated_at=NOW()
        WHERE pais_id=OLD.pais_id
            AND departamento_id=OLD.id
            AND municipio_id IS NULL
            AND centropoblado_id IS NULL
            AND vereda_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL;

        -- Actualizamos lo que está dentro del departamento en cascada (esperamos#{" "}
        -- llamada al trigger de nomenclatura para arreglar nombre_sin_pais por#{" "}
        -- ejemplo)
        UPDATE public.msip_ubicacionpre SET
          nombre=REPLACE(nombre, OLD.nombre, NEW.nombre),
          updated_at=NOW()
        WHERE pais_id=OLD.pais_id#{" "}
          AND departamento_id=OLD.id#{" "}
          AND NOT (municipio_id IS NULL
            AND centropoblado_id IS NULL
            AND vereda_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL);

        RETURN NULL;
      END ;
    $$;

    -- Cambio de pais_id por ahora es mejor en una migración
    CREATE TRIGGER msip_tras_actualizar_departamento
        AFTER UPDATE OF nombre, latitud, longitud ON msip_departamento
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_actualizar_departamento();

    -- Pero no eliminamos en cascada --tendrá que hacerse desde la aplicación 1 a 1 o con una migración
    CREATE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_departamento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        ASSERT(TG_OP = 'DELETE');
        RAISE NOTICE 'Eliminando departamento';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'OLD.id = %', OLD.id;
        RAISE NOTICE 'OLD.nombre = %', OLD.nombre;

        DELETE FROM public.msip_ubicacionpre WHERE pais_id=OLD.pais_id#{" "}
          AND departamento_id=OLD.id
          AND municipio_id IS NULL
          AND centropoblado_id IS NULL
          AND vereda_id IS NULL
          AND lugar IS NULL;
        RETURN OLD;
      END ;
      $$;

      CREATE TRIGGER msip_antes_de_eliminar_departamento
        BEFORE DELETE ON msip_departamento
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_departamento();

    EOF
  end

  def down
    execute(<<-SQL)
      DROP TRIGGER msip_antes_de_eliminar_departamento ON msip_departamento;
      DROP FUNCTION public.msip_ubicacionpre_antes_de_eliminar_departamento;

      DROP TRIGGER msip_tras_actualizar_departamento ON msip_departamento;
      DROP FUNCTION public.msip_ubicacionpre_tras_actualizar_departamento;

      DROP TRIGGER msip_tras_crear_departamento ON msip_departamento;
      DROP FUNCTION public.msip_ubicacionpre_tras_crear_departamento;
    SQL
  end
end
