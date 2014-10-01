class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_presence_of :body,:rating,:user_id,:video_id
  validates_uniqueness_of :video_id, scope: :user_id

end