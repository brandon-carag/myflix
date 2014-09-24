class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_uniqueness_of :video_id, scope: :user_id
  validates :list_order, numericality: { :greater_than_or_equal_to => 1, only_integer: true }


  default_scope { order('list_order') }
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

def count_items
  count=QueueItem.where(user_id:user_id).size
end

end

