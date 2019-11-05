class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.integer :vote_num
      t.date :joined_date
      
      t.timestamps
    end
  end
end
