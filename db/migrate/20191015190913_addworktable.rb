class Addworktable < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.string :creator
      t.integer :publication_year
      t.string :description

  
    end
  end
end
