# frozen_string_literal: true

require_relative "../../../test/test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.javascript_driver = :cuprite
  @elurl = ENV.fetch("CHROME_URL", "http://chrome:4444/wd/hub")
  puts "@elur=#{@elurl}"
  Capybara.register_driver(:cuprite) do |app|
    #if File.exist?("/.dockerenv")
      Capybara::Cuprite::Driver.new(
        app,
        window_size: [1200, 800],
        browser_options: { "no-sandbox": nil },
        inspector: true,
        url: @elurl
      )
    #else
    #  Capybara::Cuprite::Driver.new(app, window_size: [1200, 800])
    #end
  end

  driven_by :cuprite
end
