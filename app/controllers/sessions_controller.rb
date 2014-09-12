class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]


  def new
    redirect_to home_path if current_user
  end

  def create
    user=User.find_by(email:params["email"])
    if user && user.authenticate(params["password"])
      session[:user_id]=user.id
      flash[:success]="You have successfully signed in."
      redirect_to videos_path
    else
      flash[:danger]="There was something wrong with your email address or password."
      render 'new'
    end
  end
    
  def destroy
    session[:user_id]=nil
    flash[:success]="You have successfully signed out."
    redirect_to sign_in_path
  end

end