class DeleteVotesColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :votes_id
    remove_column :users, :votes_id
  end
end
