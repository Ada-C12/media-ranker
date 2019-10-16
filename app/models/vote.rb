class Vote < ApplicationRecord
  
  belongs_to :users
  belongs_to :works
  
  # only action needed is votes#create
  
  
  
end
