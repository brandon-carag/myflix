class InvitationsController < ApplicationController

  def new
  end

  def create
    if AppMailer.send_invite(params["invitation"],current_user).deliver
      flash[:success] = "Your invite has been sent!"
    else
      flash[:danger] = "Something went wrong with your invitation, please try sending again."
    end
    redirect_to new_invitation_path
  end  

end