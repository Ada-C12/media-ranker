class AddColumnToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :vote_count, :integer, :default => 0
  end
end
