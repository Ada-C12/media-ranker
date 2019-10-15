class Vote < ApplicationRecord
  belongs_to :user
  belong_to :work
end
