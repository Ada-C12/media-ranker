# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

WORKS_FILE = Rails.root.join('db', 'media-seeds.csv')
puts "Loading raw media-seeds data from #{WORKS_FILE}"

work_failures = []
CSV.foreach(WORKS_FILE, :headers => true) do |row|
  work = Work.new
  
  work.id = row['id']
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']

  successful = work.save
  if !successful
    work_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Saved work: #{work.inspect}"
  end
end

puts "Added #{Work.count} works"
puts "#{work_failures} works failed to save"



USERS_FILE = Rails.root.join('db', 'user-seeds.csv')
puts "Loading raw user-seeds data from #{USERS_FILE}"

user_failures = []
CSV.foreach(USERS_FILE, :headers => true) do |row|
  user = User.new
  
  user.id = row['id']
  user.username = row['username']

  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Saved user: #{user.inspect}"
  end
end

puts "Added #{User.count} users"
puts "#{user_failures} users failed to save"



VOTES_FILE = Rails.root.join('db', 'vote-seeds.csv')
puts "Loading raw vote-seeds data from #{VOTES_FILE}"

vote_failures = []
CSV.foreach(VOTES_FILE, :headers => true) do |row|
  vote = Vote.new

  vote.id = row['id']
  vote.work_id = row['work_id']
  vote.user_id = row['user_id']
  
  successful = vote.save
  if !successful
    vote_failures << vote
    puts "Failed to save vote: #{vote.inspect}"
  else
    puts "Created vote: #{vote.inspect}"
  end
end

puts "Added #{Vote.count} vote records"
puts "#{vote_failures.length} votes failed to save"


puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
