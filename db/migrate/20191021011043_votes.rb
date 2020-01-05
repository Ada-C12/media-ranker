class Votes < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key "users", "votes" 
    remove_foreign_key "works", "votes"
  end
end
