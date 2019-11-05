class RemoveVoteNumColumnFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column(:votes, :vote_num, :integer)
  end
end
