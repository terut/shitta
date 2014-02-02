class Message < ActionMailer::Base
  default from: "noreply@shitta.terut.net"

  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: "[Shitta] Please reset your password")
  end
end
