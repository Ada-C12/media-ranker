class AddCounterCacheColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :votes_count, :integer
    add_column :works, :votes_count, :integer
  end
end
