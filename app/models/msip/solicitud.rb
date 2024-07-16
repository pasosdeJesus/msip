# frozen_string_literal: true

require "msip/concerns/models/solicitud"

module Msip
  # Una solicitud de un usuario a otro
  class Solicitud < ActiveRecord::Base
    include Msip::Concerns::Models::Solicitud
  end
end
