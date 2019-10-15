# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

puts "Loading raw driver data from file"

work_failures = []
CSV.foreach('db/media-seeds.csv', :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year'].to_i
  work.description = row['description']
  work.vote_count = 0
  successful = work.save
  if successful
    puts "Created work: #{work.inspect}" 
  else
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"