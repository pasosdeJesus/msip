# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class TdocumentoTest < ActiveSupport::TestCase
    test "valido" do
      tdocumento = Tdocumento.create(PRUEBA_TDOCUMENTO)

      assert_predicate tdocumento, :valid?
      tdocumento.destroy
    end

    test "no valido" do
      tdocumento = Tdocumento.new(PRUEBA_TDOCUMENTO)
      tdocumento.nombre = ""

      assert_not tdocumento.valid?
      tdocumento.destroy
    end

    test "existente" do
      tdocumento = Msip::Tdocumento.find_by(id: 7)

      assert_equal("OTRO", tdocumento.nombre)
    end
  end
end
