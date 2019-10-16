class Vote < ApplicationRecord
  belongs_to :passenger
  belongs_to :driver
end
