class Work < ApplicationRecord
  has_many :votes, :through => :users
  validates :category, :creator, :publication_year, :description, presence: true
  validates :title, presence: true, uniqueness: true

  # pre-votes implementation
  def self.select_spotlight
    spotlight_work = Work.all.sample
    return spotlight_work
  end

  # pre-votes implementation
  # TO-DO: add logic to deal with no records returned
  def self.select_top_ten(category)
    result = Work.where(category: category)
    if result.empty?
      return nil
    end
    
    # if there is less than 10 records in result, display all
    if result.length < 10
      return result
    end 

    # if there's more than 10 records in result
    # find the excess and remove those records from result
    if result.length > 10
      excess_works = result.length - 10
      new_result = result.drop(excess_works)
      return new_result
    end
  end


end
