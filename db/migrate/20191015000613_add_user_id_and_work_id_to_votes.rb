class AddUserIdAndWorkIdToVotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :work
    add_reference :votes, :user
    add_index :votes, [:user_id, :work_id], unique: true
  end
end
