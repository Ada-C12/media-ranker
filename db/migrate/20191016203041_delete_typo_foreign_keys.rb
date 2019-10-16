class DeleteTypoForeignKeys < ActiveRecord::Migration[5.2]
  def change
    remove_reference :votes, :users, index: true
    remove_foreign_key :votes, :users
    remove_reference :votes, :works, index: true
    remove_foreign_key :votes, :works
  end
end
