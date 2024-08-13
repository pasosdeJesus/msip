# frozen_string_literal: true

require "msip/concerns/models/solicitud_usuarionotificar"

module Msip
  # Implementa relación n-n entre solicitud y usuarionotificar
  class SolicitudUsuarionotificar < ActiveRecord::Base
    include Msip::Concerns::Models::SolicitudUsuarionotificar
  end
end
