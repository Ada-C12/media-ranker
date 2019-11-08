class SetNilVotesCountToZero < ActiveRecord::Migration[5.2]
  def change
    Work.all.each do |work|
      if work.votes_count.nil?
        work.votes_count = 0
        work.save
      end
    end
  end
end
