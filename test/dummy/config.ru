# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative "config/environment"
rutarel = Rails.application.config.relative_url_root || "/"
if rutarel[0] != "/"
  rutarel = "/" + rutarel
end
map rutarel do
  run Rails.application
  Rails.application.load_server
end
