# frozen_string_literal: true

require_relative "../../test_helper"
require "msip/temas_helper"

module Msip
  class TemasHelperTest < ActionView::TestCase
    include TemasHelper

    test "temas_usuario" do
      t = tema_usuario(nil)

      assert_equal Msip::Tema.find(1), t
      u = Usuario.find(1)
      u.tema_id = 1
      u.save

      assert_equal Msip::Tema.find(1), tema_usuario(Usuario.find(1))
    end
  end  # class
end    # module
