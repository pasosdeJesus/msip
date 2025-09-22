# frozen_string_literal: true

module Msip
  # Virtual para facilitar unificar datos de dos personas (que en realidad
  # corresponen a una)
  class Unificarpersonas
    include ActiveModel::Model

    attr_accessor :id1
    attr_accessor :id2
  end
end
