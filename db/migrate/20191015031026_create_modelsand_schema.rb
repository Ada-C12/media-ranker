class CreateModelsandSchema < ActiveRecord::Migration[5.2]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.string :creator
      t.integer :publication_year
      t.string :description
    end

    create_table :users do |t|
      t.string :username
      t.timestamps
    end

    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :work, foreign_key: true

      t.timestamps
    end

  end
end




# rails generate model Media category:string title:string creator:string publication_year:integer description:string
