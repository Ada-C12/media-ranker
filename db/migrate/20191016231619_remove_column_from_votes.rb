class RemoveColumnFromVotes < ActiveRecord::Migration[5.2]
  def change
    
    remove_column :votes, :vote_number
  end
end
