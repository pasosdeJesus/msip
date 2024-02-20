# frozen_string_literal: true

require "msip/concerns/models/etnia"

module Msip
  class Etnia < ActiveRecord::Base
    include Msip::Concerns::Models::Etnia
  end
end
