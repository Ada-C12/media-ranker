class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.string :creator
      t.integer :published_year
      t.string :description
      t.integer :votes_earned

      t.timestamps
    end
  end
end
