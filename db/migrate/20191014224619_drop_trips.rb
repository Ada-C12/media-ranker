class DropTrips < ActiveRecord::Migration[5.2]
  def change
    drop_table :trips
  end
end