class MejoraTriggerUbicacionpreNomenclatura < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      DROP TRIGGER  tras_crear_o_actualizar_ubicacionpre
        ON public.msip_ubicacionpre;
      CREATE TRIGGER tras_crear_o_actualizar_ubicacionpre
        BEFORE INSERT OR UPDATE OF pais_id, departamento_id, municipio_id,
          centropoblado_id, vereda_id, lugar, sitio, nombre
        ON public.msip_ubicacionpre
        FOR EACH ROW EXECUTE FUNCTION public.msip_ubicacionpre_actualiza_nombre();
    SQL
  end
  def down
    execute <<-SQL
      DROP TRIGGER  tras_crear_o_actualizar_ubicacionpre
        ON public.msip_ubicacionpre;
      CREATE TRIGGER tras_crear_o_actualizar_ubicacionpre
        BEFORE INSERT OR UPDATE OF pais_id, departamento_id, municipio_id,
          centropoblado_id, vereda_id, lugar, sitio
        ON public.msip_ubicacionpre
        FOR EACH ROW EXECUTE FUNCTION public.msip_ubicacionpre_actualiza_nombre();
    SQL
  end

end
