class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :joined, :date
    add_column :users, :votes, :text
  end
end
