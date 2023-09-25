# frozen_string_literal: true

require "msip/concerns/models/respaldo7z"

module Msip
  class Respaldo7z
    include ActiveModel::Model
    include Msip::Concerns::Models::Respaldo7z
  end
end
