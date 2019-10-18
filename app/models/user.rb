class User < ApplicationRecord
  has_many :votes
  
  validates :name, presence: true
  
  def self.all_users
    joined = User.all.sort_by(&:created_at).reverse
    return joined
  end
end
