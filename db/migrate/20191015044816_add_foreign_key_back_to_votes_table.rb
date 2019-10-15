class AddForeignKeyBackToVotesTable < ActiveRecord::Migration[5.2]
  def change
    add_column(:votes, :user_id, :integer)
    add_foreign_key(:votes, :users)
  end
end
