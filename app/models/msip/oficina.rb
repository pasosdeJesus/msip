# frozen_string_literal: true

require "msip/concerns/models/oficina"

module Msip
  # Oficina de un usuario. Util para definir control de acceso.
  class Oficina < ActiveRecord::Base
    include Msip::Concerns::Models::Oficina
  end
end
