# frozen_string_literal: true

require "msip/concerns/models/etnia"

module Msip
  # Etnia de una persona. El listado de Colombia proviene del ministerio de
  # interior
  class Etnia < ActiveRecord::Base
    include Msip::Concerns::Models::Etnia
  end
end
