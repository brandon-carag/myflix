require 'spec_helper'
require 'pry'

describe SessionsController do
  describe "GET new" do
    it "redirects to home_path if user is signed in" do
      session[:user_id]=Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end

  end

  describe "POST create" do

    context "if credentials valid" do
      before do
        johndoe=Fabricate(:user) 
        post :create, email: johndoe.email, password: johndoe.password
      end

      it "assigns user.id to session hash" do #TODO: Why does this fail when the before clause above is used?  Why must this be populated manually?
        johndoe=Fabricate(:user)
        post :create, email: johndoe.email, password: johndoe.password
        expect(session[:user_id]).to eq(johndoe.id)
      end
      it "flashes success message" do
        expect(flash["success"]).to be_truthy
      end

      it "redirects to videos_path" do
        expect(response).to redirect_to videos_path
      end

    end

    context "if credentials are invalid" do
      before do
        johndoe=Fabricate(:user)
        post :create, email: johndoe.email,password: johndoe.password+"words to make the pw fail"
      end


      it "does not set the session hash if user doesn't exist" do
        post :create 
        expect(session["user_id"]).to be_nil
      end

      it "flashes error message" do
        expect(flash[:danger]).to be_truthy
      end

      it "renders new session template" do
        expect(response).to render_template('new')
      end
     end
  end
  
  describe "GET destroy" do
    it "redirects to home_path if user is not signed in" do
      get :destroy
      expect(response).to redirect_to sign_in_path

    end

    context "clears the session for the user" do
      before do
        johndoe=Fabricate(:user) 
        session[:user_id]=johndoe.id
        get :destroy
      end

      it "sets session hash to nil" do
        expect(session[:user_id]).to be_nil

      end
      it "flashes success message" do
        expect(flash[:success]).to be_truthy
      end
      it "redirects to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end
    end


  end


end