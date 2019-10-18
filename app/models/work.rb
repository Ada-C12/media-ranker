class Work < ApplicationRecord
  
  # validation: name, can't be empty
  # validation: name, can't be duplicating another name
  # category: must be one of the following 3 values: album, book, movie
  
  
  has_many :votes
end
