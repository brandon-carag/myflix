require 'spec_helper'
require 'pry'

describe UsersController do 
  before do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
  
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns :user).to be_instance_of(User)
    end

    it "redirects to home path if signed in" do  
      session[:user_id]=Fabricate(:user).id
      get :new  
      expect(response).to redirect_to home_path
    end
    
  end

  describe "GET new_with_invitation" do 
    context "token is valid" do
      it "sets @invitation" do
      test_invitation = Fabricate(:invitation)

      get :new_with_invitation, token: test_invitation.invite_token 
      expect(assigns(:invitation)).to be_instance_of(Invitation)
      end
    end

    context "token is invalid" do
      it "redirects to root path" do

      get :new_with_invitation, token: "bad_token" 

      expect(response).to redirect_to register_path
      end
    end
  end


  describe "POST create" do
    context "user input is valid" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "sets @user" do  
        #TODO: Why would we count the users instead of doing a comparison?
        expect(User.count).to eq(1)
        end

      it "redirects if @user saves" do  
        expect(response).to redirect_to sign_in_path 
      end

      it "creates a following if user is invited" do
        user_attributes = Fabricate.attributes_for(:user)
        Fabricate(:invitation,recipient_email: user_attributes["email"])

        post :create, user: user_attributes 

        expect(assigns(:user).followings.count).to eq(1)
      end

      it "creates two followings if user is invited" do
        user_attributes = Fabricate.attributes_for(:user)
        Fabricate(:invitation,recipient_email: user_attributes["email"])

        post :create, user: user_attributes 

        expect(Following.count).to eq(2)
      end

    end

    context "sending email" do
      after { ActionMailer::Base.deliveries.clear }

      it "sends out the email with valid inputs" do
        post :create, user: Fabricate.attributes_for(:user)

        expect(ActionMailer::Base.deliveries).not_to be_nil
      end

      it "sends to the right recipient" do
        attributes = Fabricate.attributes_for(:user)

        post :create, user: attributes 
        message = ActionMailer::Base.deliveries.last

        expect(message.to).to eq([attributes["email"]])
      end

      it "has the right content" do
        attributes = Fabricate.attributes_for(:user)

        post :create, user: attributes 
        message = ActionMailer::Base.deliveries.last

        expect(message.body).to include("Thanks for joining")
      end

      it "does not send out email with invalid inputs" do
        post :create, user: {email:"brandon.carag@gmail.com",password:"password"} 

        expect(ActionMailer::Base.deliveries).to be_empty
      end

    end

  describe "GET show" do
    context "user input is valid"
      it "sets @user" do
        user = Fabricate(:user)
        set_user_session(user)

        get :show, id:user.id 

        expect(assigns(:user)).to be_instance_of(User)
      end
    context "user input is invalid" do
      it "redirects to sign_in path" do
        clear_user_session
        user = Fabricate(:user)

        get :show, id:user.id

        expect(response).to redirect_to sign_in_path
      end
    end

  end

    context "user input is invalid" do
      before do
        get :create, user: {:full_name => "John Doe", :email => "john.doe@example.com"}
      end
      
      it "sets the user variable" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders new if user does not save" do
        expect(response).to render_template('new')
      end

    end

  end
end