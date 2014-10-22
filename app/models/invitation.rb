class Invitation < ActiveRecord::Base

validates_presence_of :recipient_email, :recipient_name, :message
belongs_to :user, :foreign_key => :sender_id

def generate_invite_token
  self.invite_token = SecureRandom.urlsafe_base64
  self.save
end

end