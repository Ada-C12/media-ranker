# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

WORK_FILE = Rails.root.join('db', 'seed_data', 'media-seeds.csv')
puts "Loading raw media data from #{WORK_FILE}"

work_failures = []
CSV.foreach(WORK_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication = row['publication']
  work.description = row['description']
  
  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} media records"
puts "#{work_failures.length} works failed to save"

input_users = [
  {
    name: "Shangri La"
  },
  {
    name: "Scooby Doo"
  },
  {
    name: "Lloyd Dobler"
  },
  {
    name: "Winnie LaPooh"
  },
  {
    name: "Minnie The Moocher"
  }
]

user_failures = []
input_users.each do |input_user|
  user = User.new(name: input_user[:name])
  successful = user.save
  if successful
    puts "Created user: #{user.inspect}"
  else
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"


