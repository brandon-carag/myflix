require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    context "user is authenticated" do
      before do
        set_user_session(Fabricate(:user,admin:true)) 
      end

      it "sets @video" do
        get :new

        expect(assigns(:video)).to be_instance_of(Video)
      end
    end

    context "user is unauthenticated" do
      it_behaves_like "require_sign_in" do
        let(:action) { get :new }
      end
    end

  describe "POST create" do
    context "user is authenticated" do
      context "user input is valid" do
        before do
          set_user_session(Fabricate(:user,admin:true))
          post :create, video: Fabricate.attributes_for(:video) 
        end

        it "sets @video" do
          expect(assigns(:video)).to be_instance_of(Video)
        end
        it "creates a single video" do
          expect(Video.count).to eq(1)
        end
        it "flashes a success message if the video is saved" do
          expect(flash[:success]).to be_truthy
        end
        it "redirects to the admin new videos path" do
          expect(response).to redirect_to new_admin_video_path
        end
      end

      context "user input is invalid" do 
        before do
          set_user_session(Fabricate(:user,admin:true))
          post :create, video: { title: "I'm only saving the title"} 
        end
        it "does not save a Video instance" do
          expect(Video.count).to eq(0)
        end
        it "flashes a failure message" do
          expect(flash[:danger]).to be_truthy
        end
        it "renders the new template" do
          expect(response).to render_template('new')
        end
      end
    end

    context "user is unauthenticated" do
      it_behaves_like "require_sign_in" do
        let(:action) { post :create }
      end
    end

  end
  end
end