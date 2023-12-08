class NombreUbicacionpre < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION msip_nombre_vereda ()
      RETURNS varchar AS $$
        SELECT 'Vereda '
      $$
      LANGUAGE SQL;


      CREATE OR REPLACE FUNCTION
        msip_ubicacionpre_dpa_nomenclatura(pais VARCHAR, departamento VARCHAR,
          municipio VARCHAR, vereda VARCHAR, centropoblado VARCHAR)
      RETURNS text[] AS $$
        SELECT CASE
        WHEN pais IS NULL OR pais = '' THEN
          array[NULL, NULL]
        WHEN departamento IS NULL OR departamento = '' THEN
          array[pais, NULL]
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
      $$
      LANGUAGE SQL;

      CREATE OR REPLACE FUNCTION
        msip_ubicacionpre_nomenclatura(pais VARCHAR, departamento VARCHAR,
          municipio VARCHAR, vereda VARCHAR, centropoblado VARCHAR,
          lugar VARCHAR, sitio VARCHAR)
      RETURNS text[] AS $$
        SELECT CASE
        WHEN (lugar IS NULL OR lugar = '') THEN
          msip_ubicacionpre_dpa_nomenclatura(pais, departamento,
          municipio, vereda, centropoblado)
        WHEN (sitio IS NULL OR sitio= '') THEN
          array[lugar || ' / ' || 
            (msip_ubicacionpre_dpa_nomenclatura(pais, departamento,
              municipio, vereda, centropoblado))[0],
          lugar || ' / ' || 
            (msip_ubicacionpre_dpa_nomenclatura(pais, departamento,
              municipio, vereda, centropoblado))[1] ]
        ELSE
          array[sitio || ' / ' || lugar || ' / ' || 
            (msip_ubicacionpre_dpa_nomenclatura(pais, departamento,
              municipio, vereda, centropoblado))[0],
          sitio || ' / ' || lugar || ' / ' || 
            (msip_ubicacionpre_dpa_nomenclatura(pais, departamento,
              municipio, vereda, centropoblado))[1] ]
        END
      $$
      LANGUAGE SQL;
 
      CREATE OR REPLACE FUNCTION
        msip_ubicacionpre_id_rtablabasica()
      RETURNS INT AS $$
        SELECT max(id+1) FROM msip_ubicacionpre WHERE 
          (id+1) NOT IN (SELECT id FROM msip_ubicacionpre) AND 
          id<10000000
      $$
      LANGUAGE SQL;
    SQL
  end
  def down
    execute <<-SQL
      DROP FUNCTION msip_ubicacionpre_nomenclatura;
      DROP FUNCTION msip_nombre_vereda;
    SQL
  end
end
