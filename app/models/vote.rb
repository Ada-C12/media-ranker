class Vote < ApplicationRecord
  
  belongs_to :users, :works
  
end
