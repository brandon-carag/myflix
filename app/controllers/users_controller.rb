class UsersController < ApplicationController
  
  def new    
    redirect_to home_path if current_user
    @user=User.new  
  end

  def new_with_invitation
    if @invitation = Invitation.find_by_invite_token(params["token"])
      @user = User.new
    else
      redirect_to register_path
    end
  end

  def create
    @user=User.new(params.require(:user).permit(:email,:password,:full_name))

    if @user.save
      @user.assigns_following_if_invited
      AppMailer.welcome_email(@user).deliver
      flash[:success] = "You have successfully registered.  Please sign in below."
      redirect_to sign_in_path
    else
      render 'new'
    end

  end

  def show
    require_login
    @user = User.find(params[:id])
  end

end