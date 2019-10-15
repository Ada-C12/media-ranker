class User < ApplicationRecord
  validates :username, presence: true
  
  def self.is_logged_in(session_id)
    if session_id != nil
      if User.find_by(id: session_id) != nil
        return true
      end
    end
    
    return false
  end
end
