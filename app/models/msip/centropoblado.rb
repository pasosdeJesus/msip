# frozen_string_literal: true

require "msip/concerns/models/centropoblado"

module Msip
  # Cuarto nivel en división politico administrativa cuando la ubicación
  # es urbana: centro poblado.  
  # Ver {https://gitlab.com/pasosdeJesus/division-politica}
  class Centropoblado < ActiveRecord::Base
    include Msip::Concerns::Models::Centropoblado
  end
end
