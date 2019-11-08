class DeleteTitleColumnFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column(:votes, :title)
  end
end
