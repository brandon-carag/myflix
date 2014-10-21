require 'spec_helper'
require 'pry'

describe InvitationsController do
  describe 'GET new' do
    context "user is authenticated" do
      it "assigns @invitation" do
        set_user_session

        get :new

        expect(assigns(:invitation)).to be_instance_of(Invitation)
      end
    end

    context "user is unauthenticated" do
      it "redirects to register_path" do
        clear_user_session

        get :new

        expect(response).to redirect_to sign_in_path 
      end
    end
  end

  describe 'POST create' do
    context "user is authenticated" do
      context "user input is valid" do
        it "saves an invitation record" do
          ActionMailer::Base.deliveries = []
          set_user_session

          post :create, invitation: Fabricate.attributes_for(:invitation)

          expect(Invitation.count).to eq(1)
        end

        it "sends an email" do
          ActionMailer::Base.deliveries = []
          set_user_session

          post :create, invitation: Fabricate.attributes_for(:invitation)

          expect(ActionMailer::Base.deliveries.count).to eq(1)
          # expect(ActionMailer::Base.deliveries.last.message).to include(user.auth_token)
        end

        it "sends an email to the correct recipient" do
          ActionMailer::Base.deliveries = []
          set_user_session
          test_invitation = Fabricate(:invitation) 

          post :create, invitation: test_invitation.attributes 

          expect(ActionMailer::Base.deliveries.last.message).to include(test_invitation.email)
        end


        it "populates the flash hash with a success message" do
          set_user_session

          post :create, invitation: Fabricate.attributes_for(:invitation)

          expect(flash[:success]).to be_truthy
        end

        it "generates an invitation token" do
          set_user_session

          post :create, invitation: Fabricate.attributes_for(:invitation)

          expect(Invitation.last.invite_token).to be_truthy
        end

        it "redirects to the new_invitation path" do
          set_user_session

          post :create, invitation: {recipient_email:"johndoe@email.com"} 

          expect(response).to redirect_to new_invitation_path
        end
      end
      context "user input is invalid" do
      end
    end

    context "user is unauthenticated" do
      it "redirects to register_path" do
      clear_user_session

      post :create, {recipient_email:"johndoe@email.com"} 

      expect(response).to redirect_to sign_in_path 
      end
    end

  end
end
