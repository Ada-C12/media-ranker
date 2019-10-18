class RemoveDateVotedFromVoteAttributes < ActiveRecord::Migration[5.2]
  def change
    remove_column(:votes, :date_voted, :date)
  end
end
