class Video < ActiveRecord::Base;
  belongs_to :category
  validates_presence_of :title,:description

  def self.search_by_title(query_string)
    if query_string==""
      []
    else
      Video.where("title like?","%#{query_string}%")
    end
  end


end
