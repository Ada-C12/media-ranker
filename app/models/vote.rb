class Vote < ApplicationRecord
  
  belongs_to :user
  belongs_to :work
  
  # only action needed is votes#create
  
end
