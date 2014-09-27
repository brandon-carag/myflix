require 'spec_helper'
require 'shoulda/matchers'

describe QueueItem do 
it { should belong_to(:video) }
it { should belong_to(:user) }

describe ".video_title" do
  it "returns video title" do
    video = Fabricate(:video)
    item1 = Fabricate(:queue_item,video_id:video.id)
    expect(item1.video_title).to eq(video.title)
  end

  it "returns invalid message if video_id is invalid" do
    item=Fabricate(:queue_item,video_id: 99999999999)
    expect(item.video_title).to eq("Invalid video requested")
  end
end

describe ".category_name" do
  it "returns category name" do
  video = Fabricate(:video)
  item1 = Fabricate(:queue_item,video_id:video.id)
  expect(item1.category_name).to eq(video.category.name)
  end
end

describe ".rating" do
  it "returns message if not rated" do
  user = Fabricate(:user)
  video = Fabricate(:video)
  item= Fabricate(:queue_item,user_id:user.id,video_id:video.id)

  expect(item.rating).to eq("Not Rated")

  end
  it "returns the signed in user's rating" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    item= Fabricate(:queue_item,user_id:user.id,video_id:video.id)
    review = Fabricate(:review,user_id:user.id,video_id:video.id)
    review2 = Fabricate(:review,video_id:video.id) 
    review3 = Fabricate(:review,video_id:video.id) 

    expect(item.rating).to eq(review.rating)
  end
end

describe ".update_rating" do

  it "updates the review rating if a review exists" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    item= Fabricate(:queue_item,user_id:user.id,video_id:video.id)
    review = Fabricate(:review,user_id:user.id,video_id:video.id,rating:1)

    item.update_rating(5)

    expect(item.rating).to eq(5)
  end

  it "creates a new review if no review exists" do
    user = Fabricate(:user)
    video = Fabricate(:video)
    item = Fabricate(:queue_item,user_id:user.id,video_id:video.id)

    item.update_rating(5)

    expect(item.rating).to eq(5)
  end
end

end  
