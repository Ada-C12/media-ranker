class RemoveVoteCountColumnFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :vote_count
  end
end
