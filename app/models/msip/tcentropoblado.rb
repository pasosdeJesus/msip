# frozen_string_literal: true

require "msip/concerns/models/tcentropoblado"

module Msip
  # Tipo de centro poblado. Proviene de tipología del DANE para Colombia 
  # (e.g Cabecera municipal, Área no municipalizada)
  class Tcentropoblado < ActiveRecord::Base
    include Msip::Concerns::Models::Tcentropoblado
  end
end
