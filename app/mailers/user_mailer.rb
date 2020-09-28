class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("static_pages.users_mailer.account_activationt")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("static_pages.users_mailer.pass_reset")
  end
end
