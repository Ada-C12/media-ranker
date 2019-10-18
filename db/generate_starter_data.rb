require "faker"
require "date"
require "csv"

# we already provide a filled out media_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new media_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open("db/media_seeds.csv", "w", :write_headers => true,
                                    :headers => ["category", "title", "creator", "publication_year", "description"]) do |csv|
  30.times do
    category = %w(album book movie).sample
    title = Faker::Coffee.blend_name
    creator = Faker::Name.name
    publication_year = rand(Date.today.year - 100..Date.today.year)
    description = Faker::Lorem.sentence

    csv << [category, title, creator, publication_year, description]
  end
end

CSV.open("db/user_seeds.csv", "w", :write_headers => true,
  :headers => ["name"]) do |csv|
  30.times do
    name = Faker::Name.name
    csv << [name]
  end
end

CSV.open("db/vote_seeds.csv", "w", :write_headers => true,
  :headers => ["user_id", "work_id"]) do |csv|
  30.times do |i|
    user_id = i+1
    work_id = i+1
    csv << [user_id, work_id]
  end
end