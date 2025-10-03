# JSON de detalle de Etnia
json.extract! @etnia, :id, :nombre, :descripcion, :observaciones, :fechacreacion, :fechadeshabilitacion, :created_at, :updated_at
json.habilitado @etnia.respond_to?(:fechadeshabilitacion) ? @etnia.fechadeshabilitacion.nil? : true
