class Work < ApplicationRecord
  def self.top10(type)
    works = Work.where(category: type).all.order(title: :asc)
    return works[0...9]
  end
  
  def self.spotlight
    return Work.first
  end
end