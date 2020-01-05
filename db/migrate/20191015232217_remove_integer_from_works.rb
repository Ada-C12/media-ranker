class RemoveIntegerFromWorks < ActiveRecord::Migration[5.2]
  def change
    remove_column(:works, :integer)
  end
end
