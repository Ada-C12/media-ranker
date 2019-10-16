class ChangeTypeToVotetype < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :type
    add_column :votes, :vote_type, :string
  end
end
