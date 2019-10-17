class AddDateToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :date, :datetime
  end
end
