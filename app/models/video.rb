class Video < ActiveRecord::Base;
  mount_uploader :image, SmallCoverUploader
  has_many :reviews, -> { order 'created_at DESC' }
  has_many :queue_items

  belongs_to :category
  validates_presence_of :title,:description


  def self.search_by_title(query_string)
    if query_string==""
      []
    else
      Video.where("title like?","%#{query_string}%")
    end
  end

  def avg_rating
    reviews.average(:rating).round(1) if reviews.average(:rating)
  end


end
