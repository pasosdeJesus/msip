# frozen_string_literal: true

require "test_helper"

module Msip
  class BootstrapHelperTest < ActionView::TestCase
    include Msip::BootstrapHelper

    test "helper básico funciona" do
      assert true
    end

    test "includes helper module" do
      assert_includes self.class.included_modules, Msip::BootstrapHelper
    end

    test "content_tag está disponible" do
      result = content_tag(:div, "test", class: "test-class")
      assert_includes result, "test-class"
      assert_includes result, "test"
    end

    test "link_to está disponible" do
      result = link_to("Test", "/test", class: "link-class")
      assert_includes result, "link-class"
      assert_includes result, "Test"
    end
  end
end