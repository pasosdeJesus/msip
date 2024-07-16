# frozen_string_literal: true

require "msip/concerns/models/orgsocial"

module Msip
  # Organización social. Entendemos una organización social como "un grupo de
  # personas que interactúan entre si, en virtud de que mantienen determinadas
  # relaciones sociales con el fin de obtener ciertos objetivos",  definición
  # de Méndez, J., F. Monroy y S. Zorrilla. (1993). Las organizaciones
  # sociales: conceptos básicos. En Dinámica social de las organizaciones
  # (pp. 73-105). México: McGraw-Hill.
  class Orgsocial < ActiveRecord::Base
    include Msip::Concerns::Models::Orgsocial
  end
end
