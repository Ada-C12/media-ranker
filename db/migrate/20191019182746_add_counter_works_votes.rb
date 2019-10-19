class AddCounterWorksVotes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :votes, :work
    add_reference :votes, :work, foreign_key: true, counter_cache: true
  end
end
