class User < ApplicationRecord
  has_many :votes

# validations
validates :name, presence: true

end
