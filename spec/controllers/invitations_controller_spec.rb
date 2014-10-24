require 'spec_helper'
Sidekiq::Testing.inline!

describe InvitationsController do
  describe 'GET new' do
    context "user is authenticated" do
      it "sets @invitation to a new invitation" do
        set_user_session

        get :new

        expect(assigns(:invitation)).to be_new_record
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
        after {ActionMailer::Base.deliveries.clear }

        it "saves an invitation record" do
          ActionMailer::Base.deliveries = []
          set_user_session

          post :create, invitation: Fabricate.attributes_for(:invitation)

          expect(Invitation.count).to eq(1)
        end

        it "assigns the current user as the sender" do
          user = Fabricate(:user)
          set_user_session(user)

          post :create, invitation: Fabricate.attributes_for(:invitation)

          expect(Invitation.last.sender_id).to eq(user.id)
        end

        it "sends an email" do
          ActionMailer::Base.deliveries = []
          set_user_session

          post :create, invitation: Fabricate.attributes_for(:invitation)
          expect(ActionMailer::Base.deliveries.size).to eq(1)
        end

        it "sends an email to the correct recipient" do
          ActionMailer::Base.deliveries = []
          set_user_session
          test_invitation = Fabricate(:invitation) 

          post :create, invitation: test_invitation.attributes 
          expect(ActionMailer::Base.deliveries.last.to).to include(test_invitation.recipient_email)
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

        it_behaves_like "tokenable" do
          let(:object) { Fabricate(:invitation)}
          let(:token_name) { "invite_token" }
        end

        it "sends an email with the invitation token url" do
          ActionMailer::Base.deliveries = []
          set_user_session
          test_invitation = Fabricate(:invitation) 

          post :create, invitation: test_invitation.attributes
          expect(ActionMailer::Base.deliveries.last.body).to include(Invitation.last.invite_token)
 
        end

        it "redirects to the new_invitation path" do
          set_user_session

          post :create, invitation: Fabricate.attributes_for(:invitation) 

          expect(response).to redirect_to new_invitation_path
        end
      end
      context "user input is invalid" do
        it "populates the flash hash with a failure message" do
          set_user_session

          post :create, invitation: {recipient_name:"John Doe"} 

          expect(flash[:danger]).to be_truthy
        end

        it "sets renders new template" do
          set_user_session  

          post :create, invitation: {recipient_email:"johndoe@email.com"} 

          expect(response).to render_template :new
        end

        it "sets @invitation so errors can be displayed" do
          set_user_session

          post :create, invitation: {recipient_email:"johndoe@email.com"} 

          expect(assigns(:invitation)).to be_instance_of(Invitation)
        end

      end
    end

    context "user is unauthenticated" do
      it "redirects to sign_in_path" do
        post :create, invitation: {recipient_email:"johndoe@email.com"} 

        expect(response).to redirect_to sign_in_path
      end
    end

  end
end
