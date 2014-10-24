require 'spec_helper'
require 'database_cleaner'

describe FollowingsController do

  describe 'POST create' do
    context "user is authenticated" do 
      before do
        set_user_session
      end
      context "user input is valid" do

        it "assigns @following" do
          post :create, following: Fabricate.attributes_for(:following)

          expect(assigns(:following)).to be_instance_of(Following)
        end

        it "adds a following relationship" do
          # Uncomment the Database Cleaner lines to make the test pass
          # DatabaseCleaner.strategy = :truncation
          # DatabaseCleaner.clean
          set_user_session
          post :create, following: Fabricate.attributes_for(:following)
          expect(Following.count).to eq(1)
        end

        it "redirects_to followings_path" do
          post :create, following: Fabricate.attributes_for(:following)

          expect(response).to redirect_to followings_path
        end
      end

      context "user input is invalid" do
        it "will not allow you to follow yourself" do
          user = Fabricate(:user)
          set_user_session(user)

          post :create, following: Fabricate.attributes_for(:following,followed_id:user.id)

          expect(Following.count).to eq(0)
        end

        it "will not allow you to follow a person twice" do
          user1 = Fabricate(:user)
          user2 = Fabricate(:user)
          following_relationship = Fabricate(:following,follower_id:user1.id,followed_id:user2.id)

          post :create, following: Fabricate.attributes_for(:following,follower_id:user1.id,followed_id:user2.id)

          expect(Following.count).to eq(1)
        end
      end

    end

    context "user in unauthenticated" do

      it_behaves_like "require_sign_in" do
        let(:action) { post :create, following: Fabricate.attributes_for(:following) }
      end

    end
  end

  describe 'GET index' do
    context "user is authenticated" do
      it "sets @followed" do
      user = Fabricate(:user)
      set_user_session(user)
      Fabricate(:following,follower_id:user.id)
      Fabricate(:following,follower_id:user.id)

      get :index 

      expect(assigns(:users_followed).count).to eq(2)
      end 
    end

    context "user is unauthenticated" do

      it_behaves_like "require_sign_in" do
        let(:action) { post :create, following: Fabricate.attributes_for(:following) }
      end

    end
  end

  describe 'DELETE destroy' do
    context "user is authenticated" do
      it "deletes a following record" do
        user = Fabricate(:user)
        set_user_session(user)
        following = Fabricate(:following,follower_id:user.id)

        delete :destroy, id:following.followed_id

        expect(Following.count).to eq(0)
      end
    end
    context "user is unauthenticated" do
      it "redirects to sign_in" do
        clear_user_session
        following = Fabricate(:following)

        delete :destroy, id:following.followed_id

        expect(response).to redirect_to sign_in_path
      end

      #TODO: Figure out whether shared examples have access to variables defined outside of a let statement
      it_behaves_like "require_sign_in" do
        following = Fabricate(:following)
        let(:action) { delete :destroy, id:following.followed_id }
      end
    end
  end

end

