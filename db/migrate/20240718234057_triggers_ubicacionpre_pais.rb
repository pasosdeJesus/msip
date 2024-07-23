class TriggersUbicacionprePais < ActiveRecord::Migration[7.1]
  def up
    execute <<-EOF

      CREATE FUNCTION public.msip_ubicacionpre_tras_crear_pais() RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      DECLARE
        dpa TEXT[];
      BEGIN
        ASSERT(TG_OP = 'INSERT');
        -- Los comunes se insertan manualmente con ids. diseñadas
        IF NEW.id > 1000 THEN
          RAISE NOTICE 'Insertando pais propio';
          RAISE NOTICE 'TG_OP = %', TG_OP;
          RAISE NOTICE 'NEW.id = %', NEW.id;
          RAISE NOTICE 'NEW.nombre = %', NEW.nombre;
          RAISE NOTICE 'NEW.latitud = %', NEW.latitud;
          RAISE NOTICE 'NEW.longitud = %', NEW.longitud;
          RAISE NOTICE 'NEW.observaciones = %', NEW.observaciones;

          dpa := public.msip_ubicacionpre_dpa_nomenclatura(
           NEW.nombre, '', '', '', ''
          );
          INSERT INTO public.msip_ubicacionpre (nombre, pais_id,
            departamento_id, municipio_id, centropoblado_id, vereda_id,
            lugar, sitio, tsitio_id, latitud, longitud,
            nombre_sin_pais, observaciones,
            fechacreacion, fechadeshabilitacion, created_at, updated_at)
          VALUES (dpa[1], NEW.id,
            NULL, NULL, NULL, NULL,
            NULL, NULL, NULL, NEW.latitud, NEW.longitud,
            NULL, NULL,
            NEW.fechacreacion, NULL, NOW(), NOW());
        END IF;
        RETURN NULL;
      END ;
      $$;

      CREATE TRIGGER msip_tras_crear_pais
        AFTER INSERT ON msip_pais
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_crear_pais();


      CREATE FUNCTION public.msip_ubicacionpre_tras_actualizar_pais() RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      DECLARE 
        dpa TEXT[];
      BEGIN
        ASSERT(TG_OP = 'UPDATE');
        RAISE NOTICE 'Actualizando pais';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'NEW.id = %', NEW.id;
        RAISE NOTICE 'NEW.nombre = %', NEW.nombre;
        RAISE NOTICE 'NEW.latitud = %', NEW.latitud;
        RAISE NOTICE 'NEW.longitud = %', NEW.longitud;
        RAISE NOTICE 'NEW.observaciones = %', NEW.observaciones;

        -- Actualizamos pais
        dpa := public.msip_ubicacionpre_dpa_nomenclatura(
          NEW.nombre, '', '', '', ''
        );
        UPDATE public.msip_ubicacionpre SET
          nombre=dpa[1],
          latitud=NEW.latitud,
          longitud=NEW.longitud,
          updated_at=NOW()
        WHERE pais_id=OLD.id
            AND departamento_id IS NULL 
            AND municipio_id IS NULL
            AND centropoblado_id IS NULL
            AND vereda_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL;
        
        -- Actualizamos lo que está dentro del país en cascada (esperamos 
        -- llamada al trigger de nomenclatura para arreglar nombre_sin_pais por 
        -- ejemplo)
        UPDATE public.msip_ubicacionpre SET
          nombre=REPLACE(nombre, OLD.nombre, NEW.nombre),
          updated_at=NOW()
        WHERE pais_id=OLD.id
            AND NOT (departamento_id IS NULL 
            AND municipio_id IS NULL
            AND centropoblado_id IS NULL
            AND vereda_id IS NULL
            AND lugar IS NULL
            AND sitio IS NULL);

        RETURN NULL;
      END ;
    $$;

    CREATE TRIGGER msip_tras_actualizar_pais
        AFTER UPDATE OF nombre, latitud, longitud ON msip_pais
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_tras_actualizar_pais();


    CREATE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_pais() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
      BEGIN
        ASSERT(TG_OP = 'DELETE');
        RAISE NOTICE 'Eliminando país';
        RAISE NOTICE 'TG_OP = %', TG_OP;
        RAISE NOTICE 'OLD.id = %', OLD.id;
        RAISE NOTICE 'OLD.nombre = %', OLD.nombre;

        -- Pero no elimina en cascada
        DELETE FROM public.msip_ubicacionpre WHERE pais_id=OLD.id
          AND departamento_id IS NULL 
          AND municipio_id IS NULL
          AND centropoblado_id IS NULL
          AND vereda_id IS NULL
          AND lugar IS NULL
          AND sitio IS NULL;

        RETURN OLD;
      END ;
      $$;

      CREATE TRIGGER msip_antes_de_eliminar_pais
        BEFORE DELETE ON msip_pais
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_antes_de_eliminar_pais();

    EOF
  end
  def down
    execute <<-SQL
      DROP TRIGGER msip_antes_de_eliminar_pais ON msip_pais;
      DROP FUNCTION public.msip_ubicacionpre_antes_de_eliminar_pais;

      DROP TRIGGER msip_tras_actualizar_pais ON msip_pais;
      DROP FUNCTION public.msip_ubicacionpre_tras_actualizar_pais;

      DROP TRIGGER msip_tras_crear_pais ON msip_pais;
      DROP FUNCTION public.msip_ubicacionpre_tras_crear_pais;
    SQL
  end
end
