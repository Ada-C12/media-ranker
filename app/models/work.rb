class Work < ApplicationRecord
  def self.spotlight
    self.first
  end

  def self.top_ten category
    self.where(category: category).take 10
  end
end
