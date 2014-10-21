class Invitation < ActiveRecord::Base

validates_presence_of :recipient_email, :recipient_name, :message

def generate_invite_token
  self.invite_token = SecureRandom.urlsafe_base64
  self.save
end

end