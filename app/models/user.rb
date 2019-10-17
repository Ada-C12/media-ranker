class User < ApplicationRecord
  serialize :votes, Array
end
