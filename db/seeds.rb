# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
MEDIA_FILE = Rails.root.join('db','media-seeds.csv')
puts "Loadnig data from #{MEDIA_FILE}"

work_failures = []

CSV.foreach(MEDIA_FILE, headers: true) do |row|
  # puts row["title"]
  # puts row.to_h
  work = Work.new
  # work.votes = row['votes']
  # work.upvote = row['upvote']
  work.title = row['title']
  work.category  = row['category']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']

  # work.active = false
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} works failed to save"



# Work.create(row.to_h)
