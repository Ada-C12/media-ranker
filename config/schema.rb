ActiveRecord::Schema.define(version: 2019_10_07_233744) do
  
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  
  create_table "media", force: :cascade do |t|
    t.string "category"
    t.string "title"
    t.string "creator"
    t.integer "publication_year"
    t.string "description"
  end
end
