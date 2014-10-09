class AppMailer < ActionMailer::Base
  def welcome_email(user)
    mail from: 'admin@myflix.com',to: user.email, subject: "Welcome to MyFlix!"

  end

  def forgot_pw(user)
    @user = user
    mail from: 'admin@myflix.com',to: user.email, subject: "Please reset your password"
  end
end