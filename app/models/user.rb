class User < ApplicationRecord
  validates :username, presence: true
  validates_length_of :username, minimum: 1, maximum: 25
  
  has_many :votes, dependent: :destroy

  def self.username_by_id(user_id)
    return User.find_by(id: user_id).username
  end
end
