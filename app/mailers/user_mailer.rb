class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.mail, subject: 'Account confirmation'
  end

  def password_reset(user)
    @user = user
    mail to: user.mail, subject: 'Password reset'
  end
end
