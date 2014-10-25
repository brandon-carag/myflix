require 'spec_helper'
require 'shoulda/matchers'

describe User do
  
  it { should have_many(:reviews)}
  it { should have_many(:queue_items)}
  it { should have_many(:followings)}
  it { should have_many(:followers)}
  it { should have_many(:invitations)}


  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }


  describe ".assigns_following_if_invited" do

    before do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
    end

    it "creates two followings" do
      sender = Fabricate(:user)
      recipient = Fabricate(:user)
      invitation = Fabricate(:invitation,recipient_email:recipient.email,sender_id:sender.id)

      recipient.assigns_following_if_invited

      expect(Following.count).to eq(2)
    end

    it "assigns follower_id and followed_id" do
      sender = Fabricate(:user)
      recipient = Fabricate(:user)
      invitation = Fabricate(:invitation,recipient_email:recipient.email,sender_id:sender.id)

      recipient.assigns_following_if_invited
      expect(Following.last.followed_id).to be_truthy 
      expect(Following.last.follower_id).to be_truthy 
    end
  end

end