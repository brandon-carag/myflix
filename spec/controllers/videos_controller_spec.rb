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

      it "sets @review" do
        video=Fabricate(:video)
        review1=Fabricate(:review, video_id:video.id)
        review2=Fabricate(:review, video_id:video.id)
        get :show, id: video.id
        expect(assigns(:video).reviews).to match_array([review1,review2])
      end

      it "brandon's test: displays most recent reviews first" do
        video=Fabricate(:video)

        review1=Fabricate(:review, video_id:video.id, created_at: 3.months.ago)
        review2=Fabricate(:review, video_id:video.id,created_at: 2.months.ago)
        review3=Fabricate(:review, video_id:video.id,created_at: 1.month.ago)

        get :show, id: video.id
        expect(assigns(:reviews)).to eq([review3,review2,review1])
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