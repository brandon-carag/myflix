require 'spec_helper'
require 'pry'

describe ReviewsController do 
  describe 'POST create' do
    context "with authenticated users" do
      context "with valid inputs" do
        it "redirects to the video show page" do
          session[:user_id]=Fabricate(:user).id  
          video=Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), id: video.id
          expect(response).to redirect_to video_path(video)
        end

        it "creates a review" do
          session[:user_id]=Fabricate(:user).id
          video=Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), id: video.id
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          session[:user_id]=Fabricate(:user).id  
          video=Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), id: video.id
          expect(Review.first.video).to eq(video)
        end
        
        it "creates a review associated with the signed in user" do
          user=Fabricate(:user)
          session[:user_id]=user.id  
          video=Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), id: video.id
          expect(Review.first.user).to eq(user)
        end
      end

      context "with invalid inputs" do
        it 'does not save a review' do
          session[:user_id]=Fabricate(:user).id  
          video=Fabricate(:video)
          post :create, review: { :rating => 5 }, id:video.id
          expect(Review.count).to eq(0) 
        end

        it 'displays failure message' do
          session[:user_id]=Fabricate(:user).id  
          video=Fabricate(:video)
          post :create, review: { :rating => 5 }, id:video.id
          expect(flash[:danger]).to be_truthy
        end


        it 'renders videos show template' do
          session[:user_id]=Fabricate(:user).id  
          video=Fabricate(:video)
          post :create, review: { :rating => 5 }, id:video.id
          expect(response).to render_template 'videos/show'
        end

        it 'sets @video' do
          session[:user_id]=Fabricate(:user).id  
          video=Fabricate(:video)
          post :create, review: { :rating => 5 }, id:video.id
          expect(assigns[:video]).to be_instance_of Video
        end

        it 'sets @review' do
          session[:user_id]=Fabricate(:user).id  
          video=Fabricate(:video)
          post :create, review: { :rating => 5 }, id:video.id
          expect(assigns[:review]).to be_truthy
        end
      end

      context "with unauthenticated users" do
        it "redirects the user to the sign in path" do
        session[:user_id]=nil
        video=Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), id: video.id
        expect(response).to redirect_to sign_in_path
      end
      end
    end


    

    
  end

end