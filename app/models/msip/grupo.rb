# frozen_string_literal: true

require "msip/concerns/models/grupo"

module Msip
  # Grupo de usuarios.  Puede relacionarse con organigrama. 
  # Útil por ejemplo para dar/quitar acceso.
  class Grupo < ActiveRecord::Base 
    include Msip::Concerns::Models::Grupo
  end
end
