class Category < ActiveRecord::Base;
  has_many :videos

def recent_videos
  if self.videos.size==0
    []
  else
    self.videos.order('created_at DESC').limit(6)
  end
end

end