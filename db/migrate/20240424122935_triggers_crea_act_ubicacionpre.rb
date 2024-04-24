class TriggersCreaActUbicacionpre < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION public.msip_ubicacionpre_dpa_nomenclatura(
      pais character varying, departamento character varying, municipio character varying, vereda character varying, centropoblado character varying) RETURNS text[]
      LANGUAGE sql
      AS $$
        SELECT CASE
        WHEN pais IS NULL OR pais = '' THEN
          array['', '']
        WHEN departamento IS NULL OR departamento = '' THEN
          array[pais, '']
        WHEN municipio IS NULL OR municipio = '' THEN
          array[departamento || ' / ' || pais, departamento]
        WHEN (vereda IS NULL OR vereda = '') AND
        (centropoblado IS NULL OR centropoblado = '') THEN
          array[
            municipio || ' / ' || departamento || ' / ' || pais,
            municipio || ' / ' || departamento ]
        WHEN vereda IS NOT NULL THEN
          array[
            msip_nombre_vereda() || vereda || ' / ' ||
            municipio || ' / ' || departamento || ' / ' || pais,
            msip_nombre_vereda() || vereda || ' / ' ||
            municipio || ' / ' || departamento ]
        ELSE
          array[
            centropoblado || ' / ' ||
            municipio || ' / ' || departamento || ' / ' || pais,
            centropoblado || ' / ' ||
            municipio || ' / ' || departamento ]
         END
      $$;

      CREATE OR REPLACE FUNCTION public.msip_ubicacionpre_nomenclatura(
        pais character varying, departamento character varying, 
        municipio character varying, vereda character varying, 
        centropoblado character varying, lugar character varying, 
        sitio character varying) RETURNS text[]
      LANGUAGE plpgsql
      AS $$
      DECLARE
        dpa TEXT[];
      BEGIN
        dpa := msip_ubicacionpre_dpa_nomenclatura(pais, departamento,
            municipio, vereda, centropoblado);
        --RAISE NOTICE 'dpa[1]=%', dpa[1];
        --RAISE NOTICE 'dpa[2]=%', dpa[2];
        IF (lugar IS NULL OR lugar = '') THEN
          return dpa;
        ELSEIF (sitio IS NULL OR sitio= '') THEN
          return array[
              lugar || ' / ' || dpa[1],
              lugar || ' / ' || dpa[2]
            ];
        ELSE
          return array[
              sitio || ' / ' || lugar || ' / ' || dpa[1],
              sitio || ' / ' || lugar || ' / ' || dpa[2] 
          ];
        END IF;
      END
      $$;

      CREATE OR REPLACE FUNCTION public.msip_ubicacionpre_actualiza_nombre()
        RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      DECLARE
        temp TEXT[];
        nompais TEXT;
        nomdep TEXT;
        nommun TEXT;
        nomver TEXT;
        nomcp TEXT;
      BEGIN
        RAISE NOTICE 'Al comienzo new.nombre=%', new.nombre;
        nompais := COALESCE((SELECT nombre FROM msip_pais WHERE id=new.pais_id LIMIT 1), '');
        RAISE NOTICE 'nompais=%', nompais;
        nomdep := COALESCE((SELECT nombre FROM msip_departamento WHERE id=new.departamento_id LIMIT 1), '');
        RAISE NOTICE 'nomdep=%', nomdep;
        nommun := COALESCE((SELECT nombre FROM msip_municipio WHERE id=new.municipio_id LIMIT 1), '');
        RAISE NOTICE 'nommun=%', nommun;
        nomcp := COALESCE((SELECT nombre FROM msip_centropoblado WHERE id=new.centropoblado_id LIMIT 1), '');
        RAISE NOTICE 'nomcp=%', nomcp;
        nomver := COALESCE((SELECT nombre FROM msip_vereda WHERE id=new.vereda_id LIMIT 1), '');
        RAISE NOTICE 'nomver=%', nomver;

        temp = public.msip_ubicacionpre_nomenclatura(nompais,
          nomdep, nommun, nomcp, nomver, new.lugar, new.sitio);
        new.nombre := temp[1];
        RAISE NOTICE 'new.nombre=%', new.nombre;
        new.nombre_sin_pais := temp[2];
        RAISE NOTICE 'new.nombre_sin_pais=%', new.nombre_sin_pais;
        RETURN new;
      END
      $$;
      CREATE TRIGGER tras_crear_o_actualizar_ubicacionpre 
        BEFORE INSERT OR UPDATE OF pais_id, departamento_id, municipio_id, 
          centropoblado_id, vereda_id, lugar, sitio
        ON msip_ubicacionpre
        FOR EACH ROW
        EXECUTE FUNCTION public.msip_ubicacionpre_actualiza_nombre();
    SQL
  end
  def down
    execute <<-SQL
    DROP TRIGGER tras_crear_o_actualizar_ubicacionpre ON msip_ubicacionpre;
    DROP FUNCTION public.msip_ubicacionpre_actualiza_nombre;
    SQL
  end
end
