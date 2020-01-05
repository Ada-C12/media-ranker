class AddForeignKeysToVotes < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :votes, :works
    add_reference :votes, :users
  end
end
