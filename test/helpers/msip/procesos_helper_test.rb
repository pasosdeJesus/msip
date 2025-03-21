# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class ProcesosHelperTest < ActionView::TestCase
    include ProcesosHelper

    test "procesos_OpenBSD" do
      so = %x(uname).chop
      if so == "OpenBSD"
        ps = procesos_OpenBSD

        assert_operator(ps.count, :>, 0)
        p1 = ps.select { |p| p[:pid] == 1 }.first

        assert_equal "root", p1[:user]
        assert_equal 0, p1[:ppid]
        assert_equal 1, p1[:pgid]
        assert_equal 0, p1[:sess]
        assert_equal 0, p1[:jobc]
        #        assert_equal 'I', p1[:stat]
        assert_equal "??", p1[:tt]
        assert_equal "/sbin/init", p1[:command]
      end
    end
  end  # class
end    # module
