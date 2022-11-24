# frozen_string_literal: true

require_relative "../../test_helper"
require "msip/formato_fecha_helper"

module Msip
  class LocalizaHelperTest < ActionView::TestCase
    include LocalizaHelper

    test "simple1" do
      assert_equal "Hola", capitaliza_titulo("hola")
      assert_equal "Abuso de Autoridad", capitaliza_titulo("abuso de autoridad")
      assert_equal "Abuso de Autoridad", capitaliza_titulo("ABUSO DE AUTORIDAD")
    end

    test "Extensiones a String" do
      assert_equal("3,2", "3.2".a_decimal_localizado)
      assert_equal("3.2", "3,2".a_decimal_nolocalizado)
      assert_equal("", "".a_decimal_localizado)
      assert_equal("-3,2", "-3.2".a_decimal_localizado)
      assert_equal("Altas Y Bajas", "altas y bajas".altas_bajas)
    end

    test "Extensiones a Numeric" do
      assert_equal("3,2", 3.2.a_decimal_localizado)
    end

    test "Extensiones a NilClass" do
      assert_equal("0,0", nil.a_decimal_localizado)
      assert_equal("0.0", nil.a_decimal_nolocalizado)
    end
  end  # class
end    # module
