# frozen_string_literal: true

require "msip/concerns/models/pais"

module Msip
  class Pais < ActiveRecord::Base
    include Msip::Concerns::Models::Pais
  end
end
