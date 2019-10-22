class UpdateRelatiinships < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :votes
    remove_column :users, :votes

    add_reference :works, :votes, foreign_key: true 
    add_reference :users, :votes, foreign_key: true 
  end
end
