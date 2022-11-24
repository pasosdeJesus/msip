# frozen_string_literal: true

class Ability < Msip::Ability
  # Se definen habilidades con cancancan
  # @usuario Usuario que hace petición
  def initialize(usuario = nil)
    super()
    initialize_msip(usuario)
  end
end
