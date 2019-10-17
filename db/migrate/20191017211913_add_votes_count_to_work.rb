class AddVotesCountToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :votes_count, :integer, defaul: 0
  end
end
