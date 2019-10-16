class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.int :work_id
      t.int :user_id

      t.timestamps
    end
  end
end
