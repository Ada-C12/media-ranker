class RemoveVotesEarnedFromWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :votes_earned
  end
end
