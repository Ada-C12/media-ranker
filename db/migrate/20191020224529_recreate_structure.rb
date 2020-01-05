class RecreateStructure < ActiveRecord::Migration[5.2]
  def change
    create_table "users", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "votes", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "user_id"
      t.bigint "work_id"
      t.index ["user_id"], name: "index_votes_on_user_id"
      t.index ["work_id"], name: "index_votes_on_work_id"
    end
  
    create_table "works", force: :cascade do |t|
      t.string "category"
      t.string "title"
      t.string "creator"
      t.integer "publication"
      t.string "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    add_foreign_key "votes", "users"
    add_foreign_key "votes", "works"
  
  end
end
