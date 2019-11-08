class Vote < ApplicationRecord
  
  belongs_to :work, counter_cache: true
  belongs_to :user
  
  # validates :work, uniqueness: { scope: :user }
  validates_uniqueness_of :user_id, :scope => :work, :message => 'Please enter the correct number of characters!' #:work_id  
end
