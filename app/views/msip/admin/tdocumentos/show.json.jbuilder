# JSON de detalle de Tdocumento
json.extract! @tdocumento, :id, :nombre, :sigla, :formatoregex, :observaciones, :ayuda, :fechacreacion, :fechadeshabilitacion, :created_at, :updated_at

# Campos derivados / útiles
json.habilitado @tdocumento.respond_to?(:fechadeshabilitacion) ? @tdocumento.fechadeshabilitacion.nil? : true
