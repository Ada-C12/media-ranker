class Vote < ApplicationRecord
  belongs_to :work, counter_cache: true
  belongs_to :user

  
end
