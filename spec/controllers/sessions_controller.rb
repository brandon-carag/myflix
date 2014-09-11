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
    context "verifies credentials" do
      it "does not set the session hash if user doesn't exist" do
        get :create 
        expect(session["user_id"]).to eq nil
      end

    end

    context "if credentials valid" do
      it "assigns user.id to session hash" do
        johndoe=Fabricate(:user) 
        post :create, email: johndoe.email.to_s, password: johndoe.password.to_s
        expect(session[:user_id]).to eq(johndoe.id)
      end
      it "flashes success message"
      it "redirects to videos_path"

    end

    context "if credentials are invalid" do
      it "flashes error message"
      it "renders new session template"
    end
  end
  
  describe "GET destroy" do
    it "redirects to home_path if user is not signed in"

    context "user is signed in" do
      it "sets session hash to nil"
      it "flashes success message"
      it "redirects to sign_in_path"

    end


  end


end