class FollowingsController < ApplicationController
  before_action :require_login, only: [:index,:create,:destroy]

  def index
    @users_followed = current_user.is_following
  end

  def create
    @following = Following.new(strong_parameters)
    if current_user.id != @following.followed_id && @following.save
    else
      flash[:danger] = "Something went wrong with your request to follow this user"
    end
    redirect_to followings_path
  end

  def destroy
    @following = Following.find_by(follower_id:current_user.id,followed_id:params[:id])
    if @following && @following.destroy
      flash[:success] = "Delete successful!"
    else
      flash[:danger] = "Deletion failed.  There was a problem with the request."
    end
    redirect_to followings_path
  end

  def strong_parameters
    params.require(:following).permit(:follower_id,:followed_id)
  end

end