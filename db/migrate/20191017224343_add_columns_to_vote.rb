class AddColumnsToVote < ActiveRecord::Migration[5.2]
  def change
    add_reference :votes, :user, foreign_key: true
    add_reference :votes, :work, foreign_key: true
    add_column :votes, :time, :date
  end
end
