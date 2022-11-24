# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class SolicitudTest < ActiveSupport::TestCase
    test "valido" do
      solicitud = Msip::Solicitud.new(PRUEBA_SOLICITUD)

      assert_predicate solicitud, :valid?
      solicitud.save!
      solicitud.destroy
    end

    test "no valido" do
      solicitud = Msip::Solicitud.new(PRUEBA_SOLICITUD)
      solicitud.solicitud = ""

      assert_not solicitud.valid?
      solicitud.destroy
    end
  end
end
