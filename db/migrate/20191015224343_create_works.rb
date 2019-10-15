class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :category
      t.integer :publication_year
      t.string :creator
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
