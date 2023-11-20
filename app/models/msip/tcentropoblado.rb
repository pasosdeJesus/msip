# frozen_string_literal: true

require "msip/concerns/models/tcentropoblado"

module Msip
  class Tcentropoblado < ActiveRecord::Base
    include Msip::Concerns::Models::Tcentropoblado
  end
end
