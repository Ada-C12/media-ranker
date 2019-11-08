class AddColumnPublicationYearInWorks < ActiveRecord::Migration[5.2]
  def change
    
    add_column :works, :publication_year, :integer
  end
end
