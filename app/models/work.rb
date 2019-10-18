class Work < ApplicationRecord
  has_many :votes#, dependent: :nullify
  validates :title, presence: true
  validates :category, presence: true
  validates :release_date, numericality: { only_integer: true}

  def self.sort_works(works)
    hash = {}
    works.each do |work|
      if work.votes.nil?
        hash[work.id] = 0
      else
        hash[work.id] = work.votes.length
      end
    end
    sorted_array = hash.sort_by { |key, value| -value }
    sorted_array.map! {|subarray| Work.find(subarray[0])}
  end
end

def self.top_ten
  works = Work.all
  if works.nil? || works.length == 0
    return ""
  end
  sorted_array = sort_works(works)
  if sorted_array.length < 10
    return sorted_array
  else return sorted_array[0..9]
  end
end
