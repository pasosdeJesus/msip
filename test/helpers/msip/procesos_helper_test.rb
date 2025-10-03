# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class ProcesosHelperTest < ActionView::TestCase
    include ProcesosHelper

    test "debe estar disponible el módulo helper" do
      assert_kind_of Module, ProcesosHelper
    end

    test "debe manejar sistemas no OpenBSD" do
      so = %x(uname).chop
      unless so == "OpenBSD"
        # En sistemas no OpenBSD, verificamos que esté definido el módulo
        assert_nothing_raised do
          ProcesosHelper
        end
      end
    end
  end  # class
end    # module
