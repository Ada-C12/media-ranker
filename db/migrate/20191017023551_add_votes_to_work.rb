class AddVotesToWork < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :votes, :text
  end
end