require 'spec_helper'

describe QueuesController do
  describe 'GET index' do
    context "user is authenticated" do
      it "sets @q_videos" do
        user=Fabricate(:user)
        q_video1=Fabricate(:q_video,user_id:user.id)
        q_video2=Fabricate(:q_video,user_id:user.id)
        q_video3=Fabricate(:q_video)
        expect(:q_videos).to eq(video,video3)
      end
    end
    context "user is unauthenticated" do
      it "redirects to sign_in path"
    end
  end
end