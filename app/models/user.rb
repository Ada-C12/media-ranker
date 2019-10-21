class User < ApplicationRecord
  has_many :votes, dependent: :destroy

  validates :username, presence: true

  def validate_input
    # username can't be nil and can't equal spaces  

  end

end
