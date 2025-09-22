# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # Mailer base para la aplicación.
  default from: "info@pasosdeJesus.org"
  layout "mailer"
end
