require "msip/concerns/models/grupo_usuario"

module Msip
  class GrupoUsuario < ActiveRecord::Base
    include Msip::Concerns::Models::GrupoUsuario
  end
end
