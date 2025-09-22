# frozen_string_literal: true

require "msip/concerns/controllers/etiquetas_persona_controller"

module Msip
  # Controlador de etiquetas de persona.
  class EtiquetasPersonaController < ApplicationController
    before_action :preparar_etiqueta_persona
    load_and_authorize_resource class: Msip::EtiquetaPersona

    include Msip::Concerns::Controllers::EtiquetasPersonaController
  end
end
