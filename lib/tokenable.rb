moduel Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
    
  end
    
  end

end