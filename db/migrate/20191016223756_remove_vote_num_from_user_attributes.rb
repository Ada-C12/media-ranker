class RemoveVoteNumFromUserAttributes < ActiveRecord::Migration[5.2]
  def change
    remove_column(:users, :vote_num, :integer)
  end
end
