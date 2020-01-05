class UsersVotesId < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :votes_id, :bigint
  end
end
