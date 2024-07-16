# frozen_string_literal: true

require "msip/concerns/models/respaldo7z"

module Msip
  # Virtual para facilitar respaldos con 7z
  class Respaldo7z
    include ActiveModel::Model
    include Msip::Concerns::Models::Respaldo7z
  end
end
