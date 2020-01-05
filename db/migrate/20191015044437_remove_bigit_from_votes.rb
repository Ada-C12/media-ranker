class RemoveBigitFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column(:votes, :users_id)
  end
end
