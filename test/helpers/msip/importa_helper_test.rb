# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class ImportaHelperTest < ActionView::TestCase
    include ImportaHelper

    test "nombre_en_tabla_basica" do
      menserror = "".dup # descongela

      assert_equal "Colombia", nombre_en_tabla_basica(
        Msip::Pais, "Colombia", menserror
      ).nombre
      assert_nil nombre_en_tabla_basica(Msip::Pais, "LOCOMBIA", menserror)
    end

    test "fecha_local_colombia_a_date" do
      menserror = "".dup # descongela

      assert_equal Date.new(2021, 10, 14),
        fecha_local_colombia_a_date("14/Oct/2021", menserror)
    end
  end  # class
end    # module
