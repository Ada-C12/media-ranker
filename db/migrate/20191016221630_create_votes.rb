class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.timestamps
    end
    
    add_reference :votes, :user, foreign_key: true
    add_reference :votes, :work, foreign_key: true
  end
end
