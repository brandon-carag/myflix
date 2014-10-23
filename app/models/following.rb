class Following < ActiveRecord::Base
  belongs_to :follower, :class_name => "User", :foreign_key => "follower_id" 
  belongs_to :followed, :class_name => "User", :foreign_key => "followed_id"
  validates_uniqueness_of :followed_id, scope: :follower_id 
  validates_presence_of :follower_id
  validates_presence_of :followed_id
end