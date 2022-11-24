# frozen_string_literal: true

require "msip/concerns/models/tema"

module Msip
  class Tema < ActiveRecord::Base
    include Msip::Concerns::Models::Tema
  end
end
