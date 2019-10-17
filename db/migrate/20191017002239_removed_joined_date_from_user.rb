class RemovedJoinedDateFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column(:users, :joined_date, :date)
  end
end
