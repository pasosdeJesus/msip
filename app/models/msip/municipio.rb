# frozen_string_literal: true

require "msip/concerns/models/municipio"

module Msip
  class Municipio < ActiveRecord::Base
    include Msip::Concerns::Models::Municipio
  end
end
