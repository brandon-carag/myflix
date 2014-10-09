class PasswordResetsController < ApplicationController

def new 
end

def create
  if @user = User.find_by_email(params["email"])
    @user.generate_auth_token
    # AppMailer.forgot_pw(@user).deliver
    # TODO: Make the email generate the full URL and configure ActionMailer
    render 'confirm_password_resets' 
  else
    flash["danger"] = "There was an issue with your email address or your email may be invalid."
    redirect_to new_password_reset_path
  end
end

def edit
  if (@user = User.find_by_auth_token(params[:id]) ) && @user.auth_token_expired? != false
  else
    render :text => 'Not Found', :status => '404'
  end
end

def update
  @user = User.find_by_auth_token(params[:id])
  if @user.auth_token_expired? != false && @user.update(params.require(:user).permit(:password))
    flash[:success] = "You successfully updated your password."
    redirect_to sign_in_path
  else  
    flash[:danger] = "There was a problem with updating your password"
    redirect_to new_password_reset_path 
  end 
end

end