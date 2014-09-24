class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items

  validates_presence_of :email,:password,:full_name
  validates_uniqueness_of :email
  has_secure_password validations: false

  def renumber_queue_item_list_order
    queue_items.each_with_index { |queue_item,index| queue_item.update(list_order: index+1) } 
  end

end