require 'spec_helper'

describe PasswordResetsController do 
  describe 'POST create' do
    context 'user is authenticated' do
      it "sets @user" do
        user = Fabricate(:user)

        post :create, email: user.email 

        expect(assigns(:user)).to eq(user)
      end
      it "generates an auth token if it does not exist" do
        user = Fabricate(:user)

        post :create, email: user.email 

        expect(user.reload.auth_token).to be_truthy
      end

      it "changes an auth token if it exists" do
        user = Fabricate(:user)
        user.generate_auth_token
        auth_token = user.auth_token

        post :create, email: user.email 

        expect(user.reload.auth_token).to_not eq(auth_token)
      end
    context 'emailing a user' do
      it "sends an email" do
        ActionMailer::Base.deliveries = []
        user = Fabricate(:user)

        post :create, email: user.email 

        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it "sends an email with the user's token" do
        ActionMailer::Base.deliveries = []
        user = Fabricate(:user)

        post :create, email: user.email 

        expect(ActionMailer::Base.deliveries.last.body).to include(user.auth_token)
      end
    end
    end
  end

  describe 'POST edit' do
  end
end