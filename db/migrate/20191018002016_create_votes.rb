class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.bigint :user_id
      t.bigint :work_id
      t.date :date

      t.timestamps
    end
  end
end
