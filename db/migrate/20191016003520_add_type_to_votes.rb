class AddTypeToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :type, :string
  end
end
