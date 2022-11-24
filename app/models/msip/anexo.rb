# frozen_string_literal: true

require "msip/concerns/models/anexo"

module Msip
  class Anexo < ActiveRecord::Base
    include Msip::Concerns::Models::Anexo
  end
end
