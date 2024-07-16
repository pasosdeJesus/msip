# frozen_string_literal: true

require "msip/concerns/models/usuario"

module Msip
  # Virtual: usuario del sistema.  El modelo concreto es Usuario
  class Usuario < ActiveRecord::Base
    include Msip::Concerns::Models::Usuario
  end
end
