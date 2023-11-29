class NombreUbicacionpre < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      -- Función con constante para Nombre de division Veredas
      CREATE OR REPLACE FUNCTION msip_nombre_vereda ()
      RETURNS varchar AS $$
        SELECT 'Vereda '
      $$
      LANGUAGE SQL;

      CREATE OR REPLACE FUNCTION
        msip_ubicacionpre_nomenclatura(pais VARCHAR, departamento VARCHAR,
          municipio VARCHAR, vereda VARCHAR, centropoblado VARCHAR,
          lugar VARCHAR, sitio VARCHAR)
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
          array[ municipio || ' / ' || departamento || ' / ' || pais,
            municipio || ' / ' || departamento ]
        WHEN (vereda IS NULL OR vereda = '') AND 
          (lugar IS NULL OR lugar = '') THEN
          array[ centropoblado || ' / ' || municipio || ' / ' || 
            departamento || ' / ' || pais,
            centropoblado || ' / ' || municipio || ' / ' || 
            departamento ]
        WHEN (lugar IS NULL OR lugar = '') THEN
          array[ msip_nombre_vereda() || vereda || ' / ' || 
            municipio || ' / ' ||
            departamento || ' / ' || pais,
            msip_nombre_vereda() || vereda || ' / ' || 
            municipio || ' / ' || departamento]
        WHEN (vereda IS NULL OR vereda = '') AND 
          (sitio IS NULL OR sitio = '') THEN
          array[ lugar || ' / ' || centropoblado || ' / ' ||
            municipio || ' / ' || departamento || ' / ' || pais,
            lugar || ' / ' || centropoblado || ' / ' ||
            municipio || ' / ' || departamento]
        WHEN (sitio IS NULL OR sitio = '') THEN
          array[ lugar || ' / ' || 
            msip_nombre_vereda() || vereda || ' / ' ||
            municipio || ' / ' || departamento || ' / ' || pais,
            lugar || ' / ' || 
            msip_nombre_vereda() || vereda || ' / ' ||
            municipio || ' / ' || departamento]
        WHEN (vereda IS NULL OR vereda = '') THEN
          array[ sitio || ' / ' || lugar || ' / ' ||
            centropoblado || ' / ' || 
            municipio || ' / ' ||
            departamento || ' / ' || pais,
            sitio || ' / ' || lugar || ' / ' ||
            centropoblado || ' / ' || 
            municipio || ' / ' ||
            departamento ]
        ELSE
          array[ sitio || ' / ' || lugar || ' / ' ||
            msip_nombre_vereda() || vereda || ' / ' ||
            municipio || ' / ' ||
            departamento || ' / ' || pais,
            sitio || ' / ' || lugar || ' / ' ||
            msip_nombre_vereda() || vereda || ' / ' ||
            municipio || ' / ' ||
            departamento ]
         END
      $$
      LANGUAGE SQL;

      CREATE OR REPLACE FUNCTION
        msip_ubicacionpre_id_rtablabasica()
      RETURNS INT AS $$
        SELECT min(id+1) FROM msip_ubicacionpre WHERE 
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
