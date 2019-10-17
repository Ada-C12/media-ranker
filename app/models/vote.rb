class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user
  validates_uniqueness_of :user, scope: [:work_id], :message => "has already voted for this work"  
end
