class ApplicationMailer < ActionMailer::Base
  helper Railsui::MailHelper

  default from: email_address_with_name(Railsui.config.support_email.to_s,
                                        Railsui.config.application_name.to_s)
  layout 'mailer'
end
