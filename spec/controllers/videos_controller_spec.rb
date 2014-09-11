require 'spec_helper'

describe VideosController do
  describe "GET show" do

    context "user is authenticated" do
      before do
        session[:user_id]=Fabricate(:user).id
      end
      it "sets @video" do
        video=Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
    end

    context "user is unauthenticated" do
      it "redirects user to sign_in page" do
        video=Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "GET search" do
    it "redirects to sign_in_path if user is unauthenticated" do
      get :search
      expect(response).to redirect_to sign_in_path
    end

    it "sets @search_results if user is authenticated" do
      session[:user_id]=Fabricate(:user).id
      monk=Fabricate(:video,title:"Monk")
      get :search, search_query:"Monk"
      expect(assigns(:search_results)).to eq([monk])
    end
  end
end