class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :category
      t.string :title
      t.string :creator
      t.integer :published_year
      t.string :description
      t.integer :votes

      t.timestamps
    end
  end
end
