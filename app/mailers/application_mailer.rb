# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "info@pasosdeJesus.org"
  layout "mailer"
end
