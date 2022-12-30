# frozen_string_literal: true

require_relative "../../../test/test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.javascript_driver = :cuprite
  Capybara.register_driver(:cuprite) do |app|
    if File.exist?('/.dockerenv')
      Capybara::Cuprite::Driver.new(
        app, browser_options: { 'no-sandbox': nil })
    else
      Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
    end
  end

  driven_by :cuprite
end
