class RemoveColumnDateFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :time
  end
end
