class SessionsController < ApplicationController
  def create
    user=User.find_by(email:params["email"])
    if user && user.authenticate(params[params["password"]])
      session[:user_id]=user.id
      redirect_to videos_path
    else
      render 'new'
    end
  end
    
  def destroy
    session[:user_id]=nil
    flash[:notice]="You have successfully logged out."
    redirect_to sign_in_path
  end

end