class ReviseAttributesForWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column :works, :username
  end
end
