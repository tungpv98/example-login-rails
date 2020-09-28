class ApplicationMailer < ActionMailer::Base
  default from: Settings.from_mail
  layout "mailer"
end
