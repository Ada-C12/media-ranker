class AddUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.datetime :joined_date
      t.timestamps
    end
  end
end
