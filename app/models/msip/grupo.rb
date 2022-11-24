# frozen_string_literal: true

require "msip/concerns/models/grupo"

module Msip
  class Grupo < ActiveRecord::Base
    include Msip::Concerns::Models::Grupo
  end
end
