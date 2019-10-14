class Work < ApplicationRecord
  :has_many votes
  
  validates :category, presence: true;
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_date, presence: true, numericality: { with: /\A\d{4}\z/, message: "Please Enter 4 Digit Year" }
end
