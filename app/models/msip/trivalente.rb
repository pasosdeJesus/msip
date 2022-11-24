require "msip/concerns/models/trivalente"

module Msip
  class Trivalente < ActiveRecord::Base
    include Msip::Concerns::Models::Trivalente
  end
end
