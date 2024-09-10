# frozen_string_literal: true

require "msip/concerns/models/solicitud_usuarionotificar"

module Msip
  # Relación n:n entre solicitud y usuario con los usuarios
  # por notificar sobre la solicitud
  class SolicitudUsuarionotificar < ActiveRecord::Base
    include Msip::Concerns::Models::SolicitudUsuarionotificar
  end
end
