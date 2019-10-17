# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

MEDIA_FILE = Rails.root.join('db', 'media-seeds.csv')
puts "Loading raw data from #{MEDIA_FILE}"

media_failures = []
CSV.foreach(MEDIA_FILE, :headers => true) do |row|
  work = Work.new
  work.category = row['category']
  work.title = row['title']
  work.creator = row['creator']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    media_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

USER_FILE = Rails.root.join('db', 'users-seeds.csv')
puts "Loading raw data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.username = row['username']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save work: #{user.inspect}"
  else
    puts "Created work: #{user.inspect}"
  end
end


puts "Added #{Work.count} records"
puts "#{media_failures.length} records failed to save"
puts "Added #{User.count} records"
puts "#{user_failures.length} records failed to save"

# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"