require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe 'POST update_queue' do
    context "user is authenticated" do
      before do
        Fabrication.clear_definitions
      end

      context "input is valid" do
        let(:user) { Fabricate(:user)}
        before do
          session[:user_id] = user.id
        end

        it "Assigns list_order" do
          item1 = Fabricate(:queue_item,user_id:user.id)
          item2 = Fabricate(:queue_item,user_id:user.id)
          item3 = Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=>3 ,item2.id =>2 ,item3.id => 1 },reviews:{}

          expect(item1.reload.list_order).to eq(3)
          expect(item2.reload.list_order).to eq(2)
          expect(item3.reload.list_order).to eq(1)
        end

        it "assigns list_order when list_order is not sequential" do
          item1 = Fabricate(:queue_item,user_id:user.id)
          item2 = Fabricate(:queue_item,user_id:user.id)
          item3 = Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=>8 ,item2.id =>5 ,item3.id => 2 },reviews:{}

          expect(item1.reload.list_order).to eq(3)
          expect(item2.reload.list_order).to eq(2)
          expect(item3.reload.list_order).to eq(1)

        end

        it "saves list_order for list orders with multiple digits" do
          item1 = Fabricate(:queue_item,user_id:user.id)
          item2 = Fabricate(:queue_item,user_id:user.id)
          item3 = Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=>100 ,item2.id =>50 ,item3.id => 5 },reviews:{}

          expect(item1.reload.list_order).to eq(3)
          expect(item2.reload.list_order).to eq(2)
          expect(item3.reload.list_order).to eq(1)

        end

        it "Redirects to queue_items_path" do
          item1 = Fabricate(:queue_item,user_id:user.id)
          item2 = Fabricate(:queue_item,user_id:user.id)
          item3 = Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=>3 ,item2.id =>2 ,item3.id => 1 }

          expect(response).to redirect_to queue_items_path

        end


        it "creates a review and rating" do
          video1 = Fabricate(:video)
          item1 = Fabricate(:queue_item,user_id:user.id,video_id:video1.id)  

          post :update_queue, reviews:{item1.id => 5}

          expect(item1.reload.rating).to eq(5)
          
        end

        it "updates a single review's rating" do
          video1 = Fabricate(:video)
          review1 = Fabricate(:review,user_id:user.id,rating:1)
          item1 = Fabricate(:queue_item,user_id:user.id,video_id:video1.id)  

          post :update_queue, reviews:{item1.id => 5}

          expect(item1.rating).to eq(5)
        end

      end

      context "input is invalid" do

        it "rejects attempts to edit list_order for another user's queue items" do
          user = Fabricate(:user)
          session[:user_id] = user.id
          item1 = Fabricate(:queue_item,user_id:user.id)  

          post :update_queue, queue_items:{item1.id => 1000 },reviews:{}

          expect(item1.reload.list_order).to eq(1)

        end
        it "does not save non-integer values" do
          user = Fabricate(:user)
          session[:user_id] = user.id
          item1 = Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=>"non integer text"}

          expect(flash[:danger]).to be_truthy
          expect(item1.reload.list_order).to eq(1)
        end

        it "does not save negative integers" do
          user = Fabricate(:user)
          session[:user_id] = user.id
          item1 = Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=> -1}

          expect(item1.reload.list_order).to eq(1)
        end

        it "does not save any list_order value if even one is invalid" do
          user = Fabricate(:user)
          set_user_session(user)
          item1 = Fabricate(:queue_item,user_id:user.id)
          item2 = Fabricate(:queue_item,user_id:user.id)
          item3 = Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=>3 ,item2.id =>2 ,item3.id => "bad_value" }

          expect(item1.reload.list_order).to eq(1)
          expect(item2.reload.list_order).to eq(2)
          expect(item3.reload.list_order).to eq(3)
        end


        it "does not allow blank values to be populated" do
          user = Fabricate(:user)
          set_user_session(user)
          item1=Fabricate(:queue_item,user_id:user.id)

          post :update_queue, queue_items:{item1.id=> " "}

          expect(flash[:danger]).to be_truthy
        end

        it "redirects_to queue_items_path" do
          set_user_session
          item1=Fabricate(:queue_item)

          post :update_queue, queue_items:{item1.id=> " "}

          expect(response).to redirect_to queue_items_path

        end

      end
    end
    
    context "user is unauthenticated" do
      it "redirects_to sign_in_path" do
      clear_user_session
      item1 = Fabricate(:queue_item)

      post :update_queue, queue_items:{item1.id=> "2"}

      expect(response).to redirect_to sign_in_path
      end
    end
  end


  describe 'POST create' do
    context "user is authenticated" do before do
        session[:user_id] = Fabricate(:user).id
      end
      
      it "adds queue_item" do
        post :create, queue_item: Fabricate.attributes_for(:queue_item)

        expect(QueueItem.count).to eq(1)
      end  
      it "adds queue_item for correct user" do
        user = Fabricate(:user)
        post :create, queue_item: Fabricate.attributes_for(:queue_item,user_id:user.id)
  
        expect(assigns(:queue_item).user).to eq(user)
      end

      it "adds queue_item for correct video" do
        video = Fabricate(:video)

        post :create, queue_item: Fabricate.attributes_for(:queue_item,video_id:video.id)
  
        expect(assigns(:queue_item).video).to eq(video)
      end

      it "adds queue_item to the bottom of the list order" do
        user=Fabricate(:user)
        session[:user_id] = user.id
        item1=Fabricate(:queue_item,user_id:user.id)
        item2=Fabricate(:queue_item,user_id:user.id)

        post :create, queue_item: Fabricate.attributes_for(:queue_item,user_id:user.id)

        expect(assigns(:queue_item).list_order).to eq(3)
      end 

      it "does not add the same video as a queue_item twice" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        video = Fabricate(:video)
        item1 = Fabricate(:queue_item,video_id: video.id,user_id:user.id)

        post :create, queue_item: Fabricate.attributes_for(:queue_item,video_id: video.id,user_id:user.id)

        expect(QueueItem.count).to eq(1)
      end

      it "redirects to index controller" do
        post :create, queue_item: Fabricate.attributes_for(:queue_item)

        expect(response).to redirect_to queue_items_path
      end

    context "user is unauthenticated" do

      it_behaves_like "require_sign_in" do
        let(:action) { post :create, queue_item: Fabricate.attributes_for(:queue_item) }
      end

    end
    
    end
  end

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

        it "displays queue_items by ascending list_order" do
          user=Fabricate(:user)
          session[:user_id]=user.id
          item1=Fabricate(:queue_item,user_id:user.id,list_order:1)
          item2=Fabricate(:queue_item,user_id:user.id,list_order:2)
          item3=Fabricate(:queue_item,user_id:user.id,list_order:3)
          
          get :index

          expect(assigns(:queue_items)).to eq([item1,item2,item3])
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

  describe 'get DESTROY' do
    context "user is authenticated" do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "removes a queue_item" do
        user = Fabricate(:user)
        item1=Fabricate(:queue_item,user_id:user.id)
        session[:user_id] = user.id

        post :destroy, id: item1.id

        expect(QueueItem.count).to eq(0)
      end

      it "only allows you to destroy queue_items that belong to you" do
        user = Fabricate(:user)
        another_user = Fabricate(:user)
        session[:user_id] = user.id
        another_users_item = Fabricate(:queue_item,user_id:another_user.id)

        post :destroy, id: another_users_item.id

        expect(QueueItem.count).to eq(1)
      end

      it "redirects_to queue_items_path" do
        post :destroy, id: Fabricate(:queue_item).id

        expect(response).to redirect_to queue_items_path
      end

    end

    context "user is unauthenticated" do
      it "redirects to sign_in_path" do
        clear_user_session
        item1=Fabricate(:queue_item)

        post :destroy, id: item1.id

        expect(response).to redirect_to sign_in_path
      end

    end
  end


end

