# frozen_string_literal: true

require "msip/concerns/models/vereda"

module Msip
  class Vereda < ActiveRecord::Base
    include Msip::Concerns::Models::Vereda
  end
end
