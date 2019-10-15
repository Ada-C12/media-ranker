class AddAttributesForVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :work, :integer
    add_column :votes, :user, :integer
  end
end
