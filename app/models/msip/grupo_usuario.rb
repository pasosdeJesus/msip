# frozen_string_literal: true

require "msip/concerns/models/grupo_usuario"

module Msip
  # Relacion n-n entre usuario y grupo
  class GrupoUsuario < ActiveRecord::Base
    include Msip::Concerns::Models::GrupoUsuario
  end
end
