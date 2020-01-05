class AddVotestoWorks < ActiveRecord::Migration[5.2]
  def change
    add_reference :works, :votes, foreign_key: true
  end
end
