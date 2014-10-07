class AppMailer < ActionMailer::Base
  def welcome_email(user)
    mail from: 'admin@myflix.com',to: user.email, subject: "Welcome to MyFlix!"

  end
end