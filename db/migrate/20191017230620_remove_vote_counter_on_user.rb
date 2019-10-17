class RemoveVoteCounterOnUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :votes_count
  end
end
