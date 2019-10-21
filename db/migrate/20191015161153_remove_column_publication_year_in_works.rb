class RemoveColumnPublicationYearInWorks < ActiveRecord::Migration[5.2]
  def change
    
    remove_column :works, :publication_year
  end
end
