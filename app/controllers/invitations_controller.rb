class InvitationsController < ApplicationController
  before_action :require_login

  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.new(params.require(:invitation).permit(:recipient_email,:recipient_name,:message,:sender_id).merge!(sender_id:current_user.id))
    invitation.generate_invite_token

    if invitation.save && AppMailer.send_invite(invitation,current_user).deliver
      flash[:success] = "An invitation was sent to the user"
    else
      flash[:danger] = "Something went wrong with your invitation, please try sending again."
    end
    redirect_to new_invitation_path
  end  

end