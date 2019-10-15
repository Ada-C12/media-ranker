class CreateWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :type
      t.string :title
      t.string :creator
      t.integer :release_date

      t.timestamps
    end
  end
end
