class AgregaPerfiles < ActiveRecord::Migration[7.0]
  def up
    if (Msip::Perfilorgsocial.all.count == 0) then
      execute <<-SQL
        INSERT INTO public.msip_perfilorgsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'SIN INFORMACIÓN', NULL, '2009-09-11', NULL, '2018-07-24 00:00:00', '2018-07-24 00:00:00');
        INSERT INTO public.msip_perfilorgsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'FUNCIONARIO/A O CONTRATISTA DE LA ORGANIZACIÓN', NULL, '2009-09-11', NULL, '2018-07-24 00:00:00', '2018-07-24 00:00:00');
        INSERT INTO public.msip_perfilorgsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'DIRECTIVO/A DE LA ORGANIZACIÓN', NULL, '2009-09-11', NULL, '2018-07-24 00:00:00', '2018-07-24 00:00:00');
        INSERT INTO public.msip_perfilorgsocial (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'MIEMBRO DE LA ORGANIZACIÓN', NULL, '2009-09-11', NULL, '2018-07-24 00:00:00', '2018-07-24 00:00:00');
      SQL
    end
  end
  def down
  end
end
