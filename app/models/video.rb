class Video < ActiveRecord::Base;
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
    return "Not reviewed" if self.reviews.count==0
    ratings=[]
    self.reviews.each { |review| ratings.push(review.rating) }
    avg = (ratings.sum / ratings.count.to_f).round(1)
  end


end
