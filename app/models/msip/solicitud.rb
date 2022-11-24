# frozen_string_literal: true

require "msip/concerns/models/solicitud"

module Msip
  class Solicitud < ActiveRecord::Base
    include Msip::Concerns::Models::Solicitud
  end
end
