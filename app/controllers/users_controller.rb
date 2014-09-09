class UsersController < ApplicationController
  

  def front
  end
  
  def new    
    @user=User.new  
  end

  def create
    @user=User.new(params.require(:user).permit(:email,:password,:full_name))
    if @user.save
      redirect_to root_path
    else
      binding.pry
      render 'new'
    end
  end

  def strong_params
    #TODO
  end

end