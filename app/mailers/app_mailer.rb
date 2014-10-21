class AppMailer < ActionMailer::Base
  def welcome_email(user)
    mail from: 'admin@myflix.com',to: user.email, subject: "Welcome to MyFlix!"

  end

  def forgot_pw(user)
    @user = user
    mail from: 'admin@myflix.com',to: user.email, subject: "Please reset your password"
  end

  def send_invite(invitation_info,user) 
    @invitation_info = invitation_info
    @user = user
    mail from: 'admin@myflix.com',to: invitation_info["recipient_email"], subject: "#{user.full_name} has invited you to MyFlix!"
  end

end