require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe 'GET index' do
    context "user is authenticated" do
      context "input is valid" do
        it "sets @queue_items to items owned by user" do
          user=Fabricate(:user)
          session[:user_id]=user.id
          item1=Fabricate(:queue_item,user_id:user.id)
          item2=Fabricate(:queue_item,user_id:user.id)
          item3=Fabricate(:queue_item)

          get :index

          expect(assigns(:queue_items)).to match_array([item1,item2])
        end

        it "sets @videos to video objects owned by current user" do
            user=Fabricate(:user)
            session[:user_id]=user.id
            video1=Fabricate(:video)
            video2=Fabricate(:video)
            video3=Fabricate(:video)

            item1=Fabricate(:queue_item,user_id:user.id,video_id:video1.id)
            item2=Fabricate(:queue_item,user_id:user.id,video_id:video2.id)
            item3=Fabricate(:queue_item)

            get :index

            expect(assigns(:videos)).to match_array([video1,video2])
          end
        end
      end
    context "user is unauthenticated" do
      it "redirects to sign_in path" do
        get :index

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end

