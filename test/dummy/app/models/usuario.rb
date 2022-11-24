# frozen_string_literal: true

require "msip/concerns/models/usuario"

class Usuario < ApplicationRecord
  include Msip::Concerns::Models::Usuario
end
