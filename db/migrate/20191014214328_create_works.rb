class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :title
      t.string :creator
      t.integer :published
      t.string :description
      t.string :category

      t.timestamps
    end
  end
end
