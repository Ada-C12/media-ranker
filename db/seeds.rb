# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw data from #{FILE}"

failures = []

CSV.foreach(FILE, :headers => true) do |row|
  work = Work.new
  
  invalid_category = nil
  case row["category"]
  when "album"
    work.category = "album"
  when "book"
    work.category = "book"
  when "movie"
    work.category = "movie"
  else
    invalid_category = true
  end
  
  work.title = row["title"]
  work.creator = row["creator"]
  work.published_year = row["publication_year"]
  work.description = row["description"]
  work.votes_earned = 0
  successful = work.save
  
  if !successful
    failures << work
    puts "Failed to save Work obj: #{work.inspect}"
  else
    puts "Created Work obj: #{work.inspect}"
  end
end

puts "Added #{Work.count} Work records"
puts "#{failures.length} failed to save"
puts "DONE"