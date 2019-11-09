class AddCategoryToWorks < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :category, :string
  end
end
