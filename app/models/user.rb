class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items
  has_many :followings, :foreign_key => :follower_id 
  has_many :followers, :class_name => :Following, :foreign_key => :followed_id
  has_many :invitations, :foreign_key => :sender_id 

  validates_presence_of :email,:full_name
  validates_presence_of :password, :if => :should_validate_password?
  validates_uniqueness_of :email
  has_secure_password validations: false

  attr_accessor :updating_password

  def renumber_queue_item_list_order
    queue_items.each_with_index { |queue_item,index| queue_item.update(list_order: index+1) } 
  end

  def video_in_queue?(video)
    array = queue_items.map {|n| n.video_id}
    array.include?(video.id)
  end

  def is_following 
    #Returns an array of user objects
    User.find(self.followings.map(&:followed_id))
  end

  def generate_auth_token
    self.auth_token = SecureRandom.urlsafe_base64
    self.auth_token_created_at = Time.zone.now
    self.save
  end

  def auth_token_expired?
    (Time.now - auth_token_created_at) > 7200
  end

  def should_validate_password?
    updating_password || new_record?
  end 

  def assigns_following_if_invited
    if invitation = Invitation.find_by(recipient_email:self.email)
      Following.create(followed_id:invitation.sender_id,follower_id:self.id)
      Following.create(followed_id:self.id,follower_id:invitation.sender_id)
    end
  end

  def follow_brandon
    if User.find_by(email:"brandon@email.com")
      Following.create(followed_id:User.find_by(email:"brandon@email.com").id,follower_id:self.id)
    end
  end
end