class AddColumnsToWorksModel < ActiveRecord::Migration[5.2]
  def change
    add_column :works, :category, :string
    add_column :works, :title, :string
    add_column :works, :publication_year, :integer
    add_column :works, :description, :string
  end
end
