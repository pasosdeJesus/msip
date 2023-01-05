# frozen_string_literal: true

require_relative "../../../test/test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.javascript_driver = :cuprite
  puts "CHROME_URL=#{ENV.fetch("CHROME_URL", nil)}"
  Capybara.register_driver(:cuprite) do |app|
    #if File.exist?("/.dockerenv")
      Capybara::Cuprite::Driver.new(
        app,
        window_size: [1200, 800],
        browser_options: { "no-sandbox": nil },
        inspector: true,
        url: ENV.fetch("CHROME_URL", nil),
      )
    #else
    #  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
    #end
  end

  driven_by :cuprite
end
