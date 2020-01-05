class Delete < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :vote_id, :bigint
     
   
  end
end
