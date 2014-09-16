class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video

def video_title
  if Video.where(self.video_id).exists?
    Video.find(self.video_id).title
  else
    "Invalid video requested"
  end 
end

def category_name
  video.category.name
end

def rating
  if video.reviews.find_by(user:user_id)
    obj = video.reviews.find_by(user:user_id)
    obj.rating
  else
    "Not Rated"
  end
end

end
