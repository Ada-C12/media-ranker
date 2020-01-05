class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  validates :date, presence: true

  def self.spotlight
    winner = Vote.all.group(:work_id).count.max_by do |work_id, votes| votes end
    if winner 
      winner_id = winner[0]
      return Work.find_by(id: winner_id)
    else
      return nil
    end
  end

  def self.top_ten(category)
    sorted_works = Vote.all.group(:work_id).count.sort_by do |work_id, votes| votes end
    works = []
    sorted_works.each do |work|
      if Work.find_by(id: work[0]).category == category
        works << Work.find_by(id: work[0])
      end
    end

    works.reverse!
    if works.length < 10
      return works
    else
      return works[0...9]
    end
  end
end
