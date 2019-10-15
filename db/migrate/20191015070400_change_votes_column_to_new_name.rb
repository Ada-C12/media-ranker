class ChangeVotesColumnToNewName < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :votes 
    
    add_column :movies, :votes_earned, :integer
  end
end
