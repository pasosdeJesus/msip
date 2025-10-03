# JSON de detalle de Grupo
json.extract! @grupo, :id, :nombre, :observaciones, :fechacreacion, :fechadeshabilitacion, :created_at, :updated_at
json.usuarios @grupo.respond_to?(:usuarios) ? @grupo.usuarios.map { |u| { id: u.id, nusuario: u.nusuario } } : []
json.habilitado @grupo.respond_to?(:fechadeshabilitacion) ? @grupo.fechadeshabilitacion.nil? : true
