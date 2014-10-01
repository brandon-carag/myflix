class UsersController < ApplicationController
  
  def new    
    redirect_to home_path if current_user
    @user=User.new  
  end

  def create
    @user=User.new(params.require(:user).permit(:email,:password,:full_name))
    if @user.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    require_login
    @user = User.find(params[:id])
  end

end