class ChangePublicationDateToBeString < ActiveRecord::Migration[5.2]
  def change
    change_column :works, :publication_year, :string
  end
end
