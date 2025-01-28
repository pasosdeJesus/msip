class AjustaUbicacionpre < ActiveRecord::Migration[7.2]
  # si_jrscol tenía su propia ubicacionpre
  # Se hizo una codificación diferente en msip-2.2 que pasó a msip-2.3 pero
  # no se homologo con si_jrscol (en el momento que se basaba en msip-2.2).
  # 
  # Algunas instalaciones de sivel2 quedaron con las ubicacionpre de si_jrscol
  # por lo que deben borrarse y usarse las estándares de msip
  def up
    cu = Msip::Ubicacionpre.all.count 
    if cu < 79000
      puts "Hay #{cu} registros en ubicacionpre, pero msip tiene 79836"
      puts "Se eliminaran la información de ubicacionpre y se importará la semilla de msip. Proceda solo si su sistema no usa ubicacionpre"
      puts "Ctrl-D para eliminar registros de ubicacionpre"
      puts STDIN.read
      puts "Eliminando"
      execute <<-SQL
        DELETE FROM public.schema_migrations WHERE version='20231205205600';
        DELETE FROM public.msip_ubicacionpre;
      SQL
      puts "Datos de msip_ubicacionpre eliminados"
      puts "Ejecute  nuevamente db:migrate para importar semilla de ubicacionpre de msip"
    end
  end
  def down
  end
end
