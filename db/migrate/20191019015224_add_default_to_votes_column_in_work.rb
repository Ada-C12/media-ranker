class AddDefaultToVotesColumnInWork < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :votes_count
    add_column :works, :votes_count, :integer, :default => 0
  end
end
