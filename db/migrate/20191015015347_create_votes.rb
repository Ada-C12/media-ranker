class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :vote_num
      t.date :date_voted

      t.timestamps
    end
  end
end
