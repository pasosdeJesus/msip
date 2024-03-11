class AjustaBasicas202402 < ActiveRecord::Migration[7.1]
  def up
    # Quitamos COMUNAS
    execute <<-SQL
      DELETE FROM public.msip_ubicacionpre WHERE centropoblado_id IN (
        9031, 9046, 9051, 9069, 9070, 9076, 9082, 9083, 9084, 9088
      );
      DELETE FROM public.msip_centropoblado WHERE id IN (
        9031, 9046, 9051, 9069, 9070, 9076, 9082, 9083, 9084, 9088
      );
    SQL

    # Asegurar que las ids SIN DOCUMENTO puedan ser números y letras
    if Msip::Tdocumento.where(id: 11).count > 0 # Facilita actualizaciones
      tdsd = Msip::Tdocumento.find(11)
      if tdsd.formatoregex == "[0-9]*"
        tdsd.formatoregex = "[0-9]*[A-Z]*"
        tdsd.save!
      end
    end
  end

  def down
    execute <<-SQL
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9031, 'Comuna 6', 32, 236, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9046, 'Comuna 3', 32, 233, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9051, 'Comuna 4', 32, 234, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9069, 'Comuna 9', 32, 239, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9070, 'Comuna 10', 32, 240, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9076, 'Comuna 8', 32, 238, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9082, 'Comuna 7', 32, 237, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9083, 'Comuna 5', 32, 235, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9084, 'Comuna 1', 32, 231, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
      INSERT INTO public.msip_centropoblado (id, nombre, municipio_id, cplocal_cod, tcentropoblado_id, latitud, longitud, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones, ultvigenciaini, ultvigenciafin, svgruta, svgcdx, svgcdy, svgcdancho, svgcdalto, svgrotx, svgroty) VALUES (9088, 'Comuna 2', 32, 232, 'COMUNA', NULL, NULL, '2013-06-11', '2019-03-31', NULL, NULL, '  No está en DIVIPOLA 2018.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    SQL
  end
end
