class RemoveRedundantColumnsFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :user, :integer
    remove_column :votes, :work, :integer
  end
end
